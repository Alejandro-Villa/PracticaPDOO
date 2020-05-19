require_relative "SpaceStationToUI"
require_relative "ShotResult"
require_relative "Transformation"
require_relative "CardDealer"

module Deepspace
  class SpaceStation
    private
    @@MAXFUELUNITS = 100
    @@SHIELDLOSSPERUNITSHOT = 0.1

    public
    def initialize(n, supplies)
      @name = n
      @ammoPower = supplies.ammoPower
      @fuelUnits = supplies.fuelUnits
      @shieldPower = supplies.shieldPower
      @hangar = nil
      @nMedals = 0
      @weapons = Array.new()
      @shieldBoosters = Array.new()
    end

    attr_reader :name, :ammoPower, :fuelUnits, :shieldPower, :nMedals, :hangar, :shieldBoosters, 
      :weapons, :pendingDamage

    def receiveShot(shot)
      if shot <= protection
        @shieldPower -= @@SHIELDLOSSPERUNITSHOT*shot
        @shieldPower = [0.0, @shieldPower].max
        return ShotResult::RESIST
      else
        @shieldPower = 0.0
        return ShotResult::DONOTRESIST
      end
    end

    def protection
      factor = 1
      @shieldBoosters.each { |s|
        factor*=s.useIt
      }
      @shieldPower*factor
    end

    def fire
      factor=1
      @weapons.each { |w|
        factor*=w.useIt
      }
      @ammoPower*factor
    end

    def receiveWeapon(w)
      if @hangar
        @hangar.addWeapon w
      else
        false
      end
    end

    def receiveShieldBooster(s)
      if @hangar
        @hangar.addShieldBooster s
      else
        false
      end
    end

    def receiveHangar(h) 
      if @hangar 
      else
        @hangar = Hangar.newCopy(h)
      end
      nil
    end
    
    def discardHangar
      @hangar = nil
      nil
    end

    def receiveSupplies(s)
      @ammoPower += s.ammoPower
      @shieldPower += s.shieldPower
      assignFuelUnits s.fuelUnits
      nil
    end

    def setPendingDamage(d)
      ajustado = d.adjust(@weapons.clone, @shieldBoosters.clone)
      @pendingDamage = (ajustado.hasNoEffect) ? nil : ajustado
      nil 
    end

    def mountWeapon(i)
      tmp = @hangar&.removeWeapon(i)
      if tmp
        @weapons << tmp
      end
    end

    def mountShieldBooster(i)
      tmp = @hangar&.removeShieldBooster(i)
      if tmp
        @shieldBoosters << tmp
      end
    end

    def discardShieldBoosterInHangar(i)
      @hangar&.removeShieldBooster(i)
      nil
    end

    def discardWeaponInHangar(i)
      @hangar&.removeWeapon(i)
      nil
    end

    def discardWeapon(i)
      if i >= 0 && i < @weapons.length
        w = @weapons.delete_at i
        if @pendingDamage
          @pendingDamage.discardWeapon w
          cleanPendingDamage
        end
      end
    end

    def discardShieldBooster(i)
      if i >= 0 && i < @shieldBoosters.length
        s = @shieldBoosters.delete_at i
        if @pendingDamage
          @pendingDamage.discardShieldBooster s
          cleanPendingDamage
        end
      end
    end

    def getSpeed
      @fuelUnits/@@MAXFUELUNITS
    end

    def move
        assignFuelUnits(@fuelUnits*(1-getSpeed))
        @fuelUnits = (@fuelUnits > 0) ? @fuelUnits : 0
        nil
    end

    def validState
      if @pendingDamage == nil || @pendingDamage.hasNoEffect
        @pendingDamage = nil
        return true
      else 
        return false
      end
    end

    def cleanUpMountedItems
      @weapons&.delete_if {|w| w.uses == 0}
      @shieldBoosters&.delete_if {|s| s.uses == 0}
      nil
    end

    def setLoot(loot)
      dealer = CardDealer.instance
      h = loot.getNHangars
      supp = loot.getNSupplies
      wp = loot.getNWeapons
      s = loot.getNShields
      m = loot.getNMedals

      if h > 0
        receiveHangar dealer.nextHangar
      end

      supp.times {
        receiveSupplies dealer.nextSuppliesPackage
      }

      wp.times {
        receiveWeapon dealer.nextWeapon
      }

      s.times {
        receiveShieldBooster dealer.nextShieldBooster
      }

      @nMedals += m

      return Transformation::GETEFFICIENT if loot.efficient
      return Transformation::SPACECITY if loot.spaceCity
      return Transformation::NOTRANSFORM
    end

    def getUIversion
      SpaceStationToUI.new(self)
    end

    def to_s
      s = ""
      s += "Nombre: #{name}"
      s += "\n- Poder de munición: #{ammoPower}"
      s += "\n- Combustible: #{fuelUnits}"
      s += "\n- Potencia de escudo: #{shieldPower}"
      s += "\n- Medallas: #{nMedals}"
      s += "\n- Hangar: "

      if @hangar
        s += @hangar.to_s
      else
        s += "Ninguno"
      end

      s += "\n- Armas: " + @weapons.join(',') 
      if @weapons.empty?
        s += "Ninguna"
      end
      s += "\n- Potenciadores de Escudo: " + @shieldBoosters.join(',') 
      if @shieldBoosters.empty?
        s += "Ninguno"
      end

      s += "\n- Daño pendiente:  " 
      if @pendingDamage != nil
        s += @pendingDamage.to_s
      else
        s += "Ninguno"
      end
      s
    end

    private 
    def assignFuelUnits(fu)
      @fuelUnits = (fu < @@MAXFUELUNITS) ? fu : @@MAXFUELUNITS
    end

    def cleanPendingDamage
      if @damage
        @damage = (@damage.hasNoEffect) ? nil : @damage
      end
    end
  end # class
end # module
