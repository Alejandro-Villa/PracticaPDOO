require_relative "GameStateController"
require_relative "GameUniverseToUI"
require_relative "SpaceStation"
require_relative "SpaceCity"
require_relative "PowerEfficientSpaceStation"
require_relative "BetaPowerEfficientSpaceStation"
require_relative "CombatResult"
require_relative "CardDealer"
require_relative "Dice"

module Deepspace
  class GameUniverse
    @@WIN = 10
    def initialize
      @turns = 0
      @dice = Dice.new()
      @gameState = GameStateController.new()
      @spaceStations = Array.new()
      @currentEnemy = nil
      @currentStation = nil
      @haveSpaceCity = false
    end

    def getUIversion
      GameUniverseToUI.new(@currentStation, @currentEnemy)
    end

    def state
      getState
    end

    def getState
      @gameState.state
    end

    def haveAWinner
      if @currentStation
        @currentStation&.nMedals >= @@WIN
      else
        false
      end
    end

    def init(names)
      if getState == GameState::CANNOTPLAY
        @spaceStations = Array.new
        dealer = CardDealer.instance
        names.each { |n|
          @spaceStations << SpaceStation.new(n, dealer.nextSuppliesPackage)
          @spaceStations.last.setLoot(Loot.new(0, @dice.initWithNWeapons, @dice.initWithNShields, @dice.initWithNHangars, 0))
        }
        @currentStationIndex = @dice.whoStarts(names.length)
        @currentStation = @spaceStations[@currentStationIndex]
        @currentEnemy = dealer.nextEnemy
        @gameState.next(@turns, @spaceStations.length)
      end
    end

    def combat
      if getState == GameState::BEFORECOMBAT || getState == GameState::INIT
        combatGo(@currentStation, @currentEnemy)
      else
        CombatResult::NOCOMBAT
      end
    end

    protected
    def combatGo(station, enemy)
        if @dice.firstShot == GameCharacter::ENEMYSTARSHIP
          puts "¡El enemigo dispara a tu estación!"
          if station.receiveShot(enemy.fire) == ShotResult::RESIST
            puts "Los escudos resisten el impacto. Ahora la estación contrataca"
            enemyWins = (enemy.receiveShot(station.fire) == ShotResult::RESIST)
            if enemyWins
              puts "¡No podemos penetrar sus escudos!"
            else
              puts "¡Hemos atravesado sus defensas!"
            end
          else
            puts "¡Los escudos no resisten!¡Daños en la estación!"
            enemyWins = true
          end # if station resists
        else
          puts "Tenemos ventaja, atacamos primero"
          enemyWins = (enemy.receiveShot(station.fire) == ShotResult::RESIST)
          if enemyWins
              puts "¡No podemos penetrar sus escudos!"
            else
              puts "¡Hemos atravesado sus defensas!"
            end
        end # if firstShot

        if enemyWins
          if @dice.spaceStationMoves station.getSpeed
            puts "¡Propulsores a máxima potencia!"
            station.move
            combatResult = CombatResult::STATIONESCAPES
          else
            puts "Valorando los daños sufridos..."
            station.setPendingDamage(enemy.damage)
            combatResult = CombatResult::ENEMYWINS
          end # if station moves
        else
          puts "¡Victoria! Saquead su hangar"
          transformation = station.setLoot enemy.loot
          case transformation
          when Transformation::NOTRANSFORM
            combatResult = CombatResult::STATIONWINS
          when Transformation::GETEFFICIENT
            combatResult = CombatResult::STATIONWINSANDCONVERTS
            makeStationEfficient
          when Transformation::SPACECITY
            if !@haveSpaceCity
              createSpaceCity
              combatResult = CombatResult::STATIONWINSANDCONVERTS
            else
              combatResult = CombatResult::STATIONWINS
            end
          else
            puts "Transformación `#{transformation}` no reconocida"
          end
        end # if enemyWins

        @gameState.next(@turns, @spaceStations.length)

        combatResult
    end

    public
    def nextTurn
      if getState == GameState::AFTERCOMBAT
        if @currentStation.validState
          @currentStationIndex = (@currentStationIndex + 1) % @spaceStations.length
          @turns += 1
          @currentStation = @spaceStations[@currentStationIndex]
          @currentStation.cleanUpMountedItems
          @currentEnemy = CardDealer.instance.nextEnemy
          @gameState.next(@turns, @spaceStations.length)
          true
        else
          false
        end # if station valid state
      else
        false
      end # if game state
    end


    def discardHangar
      if(state == GameState::INIT || state == GameState::AFTERCOMBAT)
        @currentStation.discardHangar
      end
    end
    
    def discardShieldBooster(i)
      if(state == GameState::INIT || state == GameState::AFTERCOMBAT)
        @currentStation.discardShieldBooster(i)
      end
    end
    
    def discardShieldBoosterInHangar(i)
      if(state == GameState::INIT || state == GameState::AFTERCOMBAT)
        @currentStation.discardShieldBoosterInHangar(i)
      end
    end  
    
    def discardWeapon(i)
      if(state == GameState::INIT || state == GameState::AFTERCOMBAT)
        @currentStation.discardWeapon(i)
      end
    end
    
    def discardWeaponInHangar(i)
      if(state == GameState::INIT || state == GameState::AFTERCOMBAT)
        @currentStation.discardWeaponInHangar(i)
      end
    end

    def mountShieldBooster(i)
      if(state == GameState::INIT || state == GameState::AFTERCOMBAT)
        @currentStation.mountShieldBooster(i)
      end
    end
    
    def mountWeapon(i)
      if(state == GameState::INIT || state == GameState::AFTERCOMBAT)
        @currentStation.mountWeapon(i)
      end
    end

    attr_reader :currentStation

    private
    def createSpaceCity
      if !@haveSpaceCity
        collaborators = Array.new
        @spaceStations.each{ |s|
          if s != @currentStation
            collaborators << s
          end
        }
        city = SpaceCity.new(@currentStation, collaborators)
        @currentStation = city
        @spaceStations[@currentStationIndex] = city
        @haveSpaceCity = true
      end
      nil
    end

    def makeStationEfficient
      if @dice.extraEfficiency
        ef = BetaPowerEfficientSpaceStation.new @currentStation
        @currentStation = ef
      else
        ef = PowerEfficientSpaceStation.new @currentStation
        @currentStation = ef
      end
    end
  end # class
end # module
