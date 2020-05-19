require_relative "WeaponToUI"

module Deepspace
  class Weapon
    def initialize(n, wt, u)
      @name = n
      @type = wt
      @uses = u
    end

    attr_reader :type, :uses

    def self.newCopy(otro)
      otro.clone
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

    def getUIversion
      WeaponToUI.new(self)
    end

    def to_s
      "Nombre: #{@name} - Tipo: #{type} - Usos #{uses}"
    end

    def clone
      Weapon.new(@name, @type.clone, @uses)
    end
  end
end
