module Deepspace
  class SuppliesPackage
    def initialize(a, f, s)
      @ammoPower = a
      @fuelUnits = f
      @shieldPower = s
    end

    def self.newCopy(otro)
      s = otro.clone
    end

    def getAmmoPower
      @ammoPower
    end

    def getFuelUnits
      @fuelUnits
    end

    def getShieldPower
      @shieldPower
    end
  end
end
