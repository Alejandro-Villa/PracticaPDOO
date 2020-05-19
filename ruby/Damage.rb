require_relative "DamageToUI"

module Deepspace
  class Damage
    private_class_method :new
    def initialize(nw, ns, warr)
      @nWeapons = nw
      @nShields = ns
      @weapons = warr
    end

    public

    attr_reader :nWeapons, :nShields, :weapons

    def copy 
    end
    def discardWeapon w 
    end
    def hasNoEffect 
    end
    def adjust(w, s) end
    def to_s 
    end

    def discardShieldBooster s 
      if @nShields > 0
        @nShields -= 1
      end
    end

    def getUIversion
      DamageToUI.new(self)
    end
  end # class
end # module
