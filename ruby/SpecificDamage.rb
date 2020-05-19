require_relative "SpecificDamageToUI"

module Deepspace
  class SpecificDamage < Damage
    public_class_method :new
    def initialize(warr, ns)
      super(-1, ns, warr)
    end
    
    def arrayContainsType(w, t) 
      if (i = w.index{ |obj| obj.type.to_s == t.to_s }) != nil
        return i
      else
        return -1
      end
    end
    private :arrayContainsType

    def self.newCopy(d)
      arr = Array.new
      d.weapons.each {|w| arr << w.clone}
      SpecificDamage.new(arr, d.nShields)
    end

    def copy
      SpecificDamage.newCopy(self)
    end

    def discardWeapon w
      if !@weapons.empty?
        if (i = @weapons.index{|t| t.to_s == w.type.to_s}) != nil
          @weapons.delete_at(i)
        end
      end
      nil
    end

    def hasNoEffect
      @weapons.empty? && @nShields <= 0
    end

    def adjust(w,s)
      if !@weapons.empty?
        tmp = Array.new
        @weapons.each{ |t|
          if (index = arrayContainsType(w,t)) != -1
            tmp << t
            w.delete_at(index)
          end
        }
      end
      return SpecificDamage.new(tmp, [@nShields, s.length].min)
    end

    def getUIversion
      SpecificDamageToUI.new(self)
    end

    def to_s
      "Armas: " + weapons.join(',') + " Escudos: #{nShields}"
    end
  end # class
end # module
