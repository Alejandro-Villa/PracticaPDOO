module Deepspace

  class Loot
    def initialize(sup, weap, shields, hangars, medals)
      @nSupplies = sup
      @nWeapons = weap
      @nShields = shields
      @nHangars = hangars
      @nMedals = medals
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
  end
end
