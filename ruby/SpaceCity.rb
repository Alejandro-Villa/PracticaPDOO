require_relative "SpaceStation"
require_relative "SpaceCityToUI"

module Deepspace
  class SpaceCity < SpaceStation
    def initialize(base, rest)
      @base = base
      super(base.name, SuppliesPackage.new(base.ammoPower, base.fuelUnits, base.shieldPower))
      @hangar = base.hangar
      @nMedals = base.nMedals
      @weapons = base.weapons
      @shieldBoosters = base.shieldBoosters


      @collaborators = Array.new
      rest.each { |s| @collaborators << s }
    end

    attr_reader :base, :collaborators

    def fire()
      shot = super
      @collaborators.each { |s| shot += s.fire }
      shot
    end

    def protection()
      shield = super
      @collaborators.each { |s| shield += s.protection }
      shield
    end

    def getUIversion()
      return SpaceCityToUI.new(self)
    end

    def setLoot(loot)
      tmp = super(loot)
      return Transformation::NOTRANSFORM
    end
  end # class
end # module
