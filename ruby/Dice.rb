require_relative "GameCharacter"

module Deepspace
  class Dice
    def initialize
      @NHANGARSPROB = 0.25
      @NSHIELDSPROB = 0.25
      @NWEAPONSPROB = 0.33
      @FIRSTSHOTPROB = 0.5
      @EXTRAEFFICIENCYPROB = 0.8

      @generator = Random.new
    end

    def initWithNHangars
      if @generator.rand < @NHANGARSPROB
        0
      else
        1
      end
    end

    def initWithNWeapons
      rng = @generator.rand
      if rng < @NWEAPONSPROB
        1
      elsif rng < 2*@NWEAPONSPROB
        2
      else
        3
      end
    end

    def initWithNShields
      if @generator.rand < @NSHIELDSPROB
        0
      else
        1
      end
    end

    def whoStarts(nPlayers)
      @generator.rand(nPlayers)
    end

    def firstShot
      if @generator.rand < @FIRSTSHOTPROB
        GameCharacter::SPACESTATION
      else
        GameCharacter::ENEMYSTARSHIP
      end
    end

    def spaceStationMoves(speed)
      if @generator.rand < speed
        true
      else
        false
      end
    end

    def extraEfficiency
      @generator.rand < @EXTRAEFFICIENCYPROB
    end 
  end # class
end # module
