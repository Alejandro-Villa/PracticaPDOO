require_relative "Damage"
require_relative "NumericDamageToUI"

module Deepspace
  class NumericDamage < Damage
    public_class_method :new
    def initialize(nw, ns)
      super(nw, ns, Array.new)
    end

    def self.newCopy(d)
      NumericDamage.new(d.nWeapons, d.nShields)
    end

    def copy
      NumericDamage.newCopy(self)
    end

    def discardWeapon w
      if @nWeapons > 0
        @nWeapons -= 1
      end
      nil
    end

    def hasNoEffect
      @nShields <= 0 && @nWeapons <= 0
    end

    def adjust(w,s)
      return NumericDamage.new([@nWeapons, w.length].min, [@nShields, s.length].min)
    end

    def getUIversion
      NumericDamageToUI.new(self)
    end

    def to_s
      "Armas #{nWeapons} Escudos: #{nShields}"
    end
  end # class
end # module
