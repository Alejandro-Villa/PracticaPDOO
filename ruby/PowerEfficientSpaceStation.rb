require_relative "SpaceStation"
require_relative "PowerEfficientSpaceStationToUI"

module Deepspace
  class PowerEfficientSpaceStation < SpaceStation
    @EFFICIENCYFACTOR = 1.10
    def self.EFFICIENCYFACTOR
      @EFFICIENCYFACTOR
    end

    def initialize(station)
      spp = SuppliesPackage.new(station.ammoPower, station.fuelUnits, station.shieldPower)
      super(station.name, spp)
      @hangar = station.hangar
      @nMedals = station.nMedals
      @weapons = Array.new
      station.weapons.each{|w| @weapons << w.clone}
      @shieldBoosters = Array.new
      station.shieldBoosters.each{|s| @shieldBoosters << s.clone}
    end

    def getUIversion()
      return PowerEfficientSpaceStationToUI.new(self)
    end

    def fire
      super * PowerEfficientSpaceStation.EFFICIENCYFACTOR
    end
    
    def protection
      super * PowerEfficientSpaceStatio.EFFICIENCYFACTOR
    end

    def setLoot(loot) # redefinicion
      transformation = super(loot) 
      case transformation
      when Transformation::SPACECITY
        return Transformation::NOTRANSFORM
      else
        return transformation
      end
    end
  end #class
end #module
