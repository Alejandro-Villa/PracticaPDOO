module Deepspace
  class Weapon
    def initialize(n, wt, u)
      @name = n
      @type = wt
      @uses = u
    end

    def self.newCopy(otro)
      cp = otro.clone
    end

    def getType
      @type
    end

    def getUses
      @uses
    end

    def power
      @type.getPower
    end

    def useIt
      if @uses > 0
        @uses -= 1
        power
      else
        1.0
      end
    end

    def clone
      clon = Weapon.new(@name, @type.clone, @uses)
    end
  end
end
