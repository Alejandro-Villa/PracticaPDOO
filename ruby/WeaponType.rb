module Deepspace
  module WeaponType
    class Type
      def initialize(pwr)
        @power = pwr
      end

      def getPower
        @power
      end

      def clone
        Type.new(@power)
      end

      def to_s
        case getPower
        when 2.0
          "LASER"
        when 3.0
          "MISSILE"
        when 4.0
          "PLASMA"
        else
          "UNKNOWN"
        end
      end
    end

    LASER=Type.new(2.0)
    MISSILE=Type.new(3.0)
    PLASMA=Type.new(4.0)
  end
end
