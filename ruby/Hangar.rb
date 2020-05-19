require_relative "HangarToUI"

module Deepspace
  class Hangar
    def initialize(capacity)
      @maxElements = capacity
      @weapons = Array.new
      @shieldBoosters = Array.new
    end

    def self.newCopy(h)
      h.clone
    end
    
    attr_reader :maxElements, :weapons, :shieldBoosters

    def addWeapon(w)
      if spaceAvailable
        @weapons.push(w)
      end
    end

    def addShieldBooster(s)
      if spaceAvailable
        @shieldBoosters.push(s)
      end
    end

    def removeWeapon(i)
      if i >= 0 && i < @weapons.length
        ret = @weapons[i]
        @weapons.delete_at i
        return ret
      end
    end

    def removeShieldBooster(i)
      if i >= 0 && i < @shieldBoosters.length
        ret = @shieldBoosters[i]
        @shieldBoosters.delete_at i
        return ret
      end
    end

    def clone
      h = Hangar.new(@maxElements)
      @weapons.each { |w| h.weapons.push(w.clone) }
      @shieldBoosters.each { |s| h.shieldBoosters.push(s.clone)}
      h
    end

    def getUIversion
      HangarToUI.new(self)
    end

    def to_s
      s = "Hangar de capacidad #{maxElements}\n- Contenido:"
      s += @weapons.join(',')
      s += @shieldBoosters.join(',')
      s
    end

    private
    def spaceAvailable
      (@weapons.length + @shieldBoosters.length) < @maxElements
    end
  end
end
