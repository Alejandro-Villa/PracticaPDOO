require_relative "PowerEfficientSpaceStation"
require_relative "BetaPowerEfficientSpaceStationToUI"
require_relative "Dice"

module Deepspace
  class BetaPowerEfficientSpaceStation < PowerEfficientSpaceStation
    @EFFICIENCYFACTOR = 1.20
    def self.EFFICIENCYFACTOR
      @EFFICIENCYFACTOR
    end

    def initialize(station)
      super
      @dice = Dice.new
    end

    def getUIversion()
      return BetaPowerEfficientSpaceStationToUI.new(self)
    end

    def setLoot(loot)
      super
    end

    def fire
      if @dice.extraEfficiency
        super * BetaPowerEfficientSpaceStation.EFFICIENCYFACTOR
      else
        super
      end
    end
  end #class
end #module
