require_relative "LootToUI"

module Deepspace
  class Loot
    def initialize(sup, weap, shields, hangars, medals, ef=false, city=false)
      @nSupplies = sup
      @nWeapons = weap
      @nShields = shields
      @nHangars = hangars
      @nMedals = medals
      @efficient = ef
      @spaceCity = city
    end

    def self.newCopy(l)
      l.clone
    end

    attr_reader :nSupplies, :nWeapons, :nShields, :nHangars, :nMedals, :efficient, :spaceCity

    def to_s
      "Suministros: #{nSupplies} - Armas: #{nWeapons} - Escudos: #{nShields} - Hangares: #{nHangars} - Medallas: #{nMedals} - Efficient: #{efficient} - Space City: #{spaceCity}"
    end

    def getNSupplies
      @nSupplies
    end

    def getNWeapons
      @nWeapons
    end

    def getNShields
      @nShields
    end

    def getNHangars
      @nHangars
    end

    def getNMedals
      @nMedals
    end

    def getUIversion
      LootToUI.new(self)
    end

    def clone  # Overrided to do deep copy instead
      Loot.new(nSupplies, nWeapons, nShields, nHangars, nMedals, efficient, spaceCity)
    end
  end
end
