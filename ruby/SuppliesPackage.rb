module Deepspace
  class SuppliesPackage
    def initialize(a, f, s)
      @ammoPower = a
      @fuelUnits = f
      @shieldPower = s
    end

    def self.newCopy(otro)
      otro.clone
    end

    attr_reader :ammoPower, :fuelUnits, :shieldPower

    def getAmmoPower
      @ammoPower
    end

    def getFuelUnits
      @fuelUnits
    end

    def getShieldPower
      @shieldPower
    end

    def to_s
      "Munición: #{ammoPower} - Combustible: #{fuelUnits} - Escudos #{shieldPower}"
    end
  end
end
