require_relative "ShieldToUI"

module Deepspace
  class ShieldBooster
    def initialize(n, b, u)
      @name = n
      @boost = b
      @uses = u
    end

    def self.newCopy(otro)
      otro.clone
    end

    attr_reader :name, :boost, :uses

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
    
    def getUIversion
      ShieldToUI.new(self)
    end

    def to_s
      "Nombre: #{name} - Potenciador: #{boost} - Usos: #{uses}"
    end

    def clone
      s = ShieldBooster.new(@name, @boost, @uses)
    end
  end # class
end # module
