require_relative "EnemyToUI"

module Deepspace
  class EnemyStarShip
    def initialize(n, a, s, l, d)
      @name = n
      @ammoPower = a
      @shieldPower = s
      @loot = Loot.newCopy(l)
      @damage = d.copy
    end

    attr_reader :name, :ammoPower, :shieldPower, :loot, :damage

    def self.newCopy(other)
      other.clone
    end

    def to_s
      "Nombre: #{name} - Munición: #{ammoPower} - Escudos #{shieldPower}\n- Botín: #{loot}\n- Daño: #{damage}"
    end

    def fire
      @ammoPower
    end

    def protection
      @shieldPower
    end
    
    def receiveShot(shot)
      if shot > protection
        return ShotResult::DONOTRESIST
      else
        return ShotResult::RESIST
      end
    end

    def getUIversion
      EnemyToUI.new(self)
    end

    def clone # Overrided to do deep copy instead
      EnemyStarShip.new(name, ammoPower, shieldPower, Loot.newCopy(loot), damage.copy)
    end
  end
end
