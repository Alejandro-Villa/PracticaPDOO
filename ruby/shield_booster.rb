module Deepspace
  class ShieldBooster
    def initialize(n, b, u)
      @name = n
      @boost = b
      @uses = u
    end

    def self.newCopy(otro)
      n = otro.clone
    end

    def getBoost
      @boost
    end

    def getUses
      @uses
    end

    def useIt
      if @uses > 0
        @uses -= 1
        @boost
      else
        1.0
      end
    end
  end
end
