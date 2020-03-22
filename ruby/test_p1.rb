#encoding: UTF-8

require_relative "combat_result.rb"
require_relative "game_character.rb"
require_relative "shot_result.rb"
require_relative "weapon_type.rb"
require_relative "loot.rb"
require_relative "supplies_package.rb"
require_relative "shield_booster.rb"
require_relative "weapon.rb"
require_relative "dice.rb" 

module Deepspace
  class TestP1
    def initialize
    end

    public
    def main
      puts "Prueba Loot"
      # Probamos que la clase Loot funciona, creando una instancia suya
      botin = Loot.new(1,2,3,4,5)
      puts botin.inspect
      # Veamos que funcionan los consultores
      puts "Suministros: " + botin.getNSupplies.to_s
      puts "Armas: " + botin.getNWeapons.to_s
      puts "Escudos: " + botin.getNShields.to_s
      puts "Hangares: " + botin.getNHangars.to_s
      puts "Medallas: " + botin.getNMedals.to_s

      puts "=================================================="
      puts "Prueba SuppliesPackage"
      # Probamos que la clase SuppliesPackage funciona, creando una instancia suya
      suppkg = SuppliesPackage.new(0.5, 1.5, 2.2)
      puts suppkg.inspect
      # Probamos el constructor de copia
      otro = SuppliesPackage.newCopy(suppkg)
      puts suppkg.inspect + " == " + otro.inspect
      # Probamos los consultores
      puts "Munición: " + suppkg.getAmmoPower.to_s
      puts "Combustible: " + suppkg.getFuelUnits.to_s
      puts "Escudo: " + suppkg.getShieldPower.to_s

      puts "=================================================="
      puts "Prueba ShieldBooster"
      # Probamos la clase ShieldBooster, creando una instancia suya
      shield = ShieldBooster.new("Escudo1", 1.55, 1)
      puts shield.inspect
      # Probamos el constructor de copia
      copia = ShieldBooster.newCopy(shield)
      puts shield.inspect + " == " + copia.inspect
      # Probamos los consultores
      puts "Boost: " + shield.getBoost.to_s
      puts "Usos: " + shield.getUses.to_s
      # Probamos el método useIt
      puts "Usando... el boost es " + shield.useIt.to_s
      puts "Usando de nuevo, ahora: " + shield.useIt.to_s

      puts "=================================================="
      puts "Prueba Weapon"
      # Probamos la clase Weapon
      w = Weapon.new("Ion Cannon", WeaponType::LASER, 1)
      puts w.inspect
      # Probamos el constructor de copia
      wcopy = Weapon.newCopy(w)
      puts w.inspect + " == " + wcopy.inspect
      # Probamos los consultores
      puts "Tipo: " + w.getType.to_s
      puts "Usos: " + w.getUses.to_s
      # Probamos el método power()
      puts "Potencia: " + w.power().to_s
      # Probamos useIt()
      puts "Usando un disparo: " + w.useIt.to_s
      puts "Otro: " + w.useIt.to_s

      puts "=================================================="
      puts "Prueba Dice"
      # Probamos la clase Dice
      dado = Dice.new
      # Prueba de los métodos:
      hangarcount = 0
      weaponcount = 0
      shieldcount = 0
      sscount = 0
      movecount = 0
      for i in 0..100
        if dado.initWithNHangars == 0
          hangarcount += 1
        end
        if dado.initWithNWeapons == 1 
          weaponcount += 1
        end
        if dado.initWithNShields == 0
          shieldcount += 1
        end
        if dado.firstShot == GameCharacter::SPACESTATION
          sscount += 1
        end
        if dado.spaceStationMoves(0.5) == true
          movecount += 1
        end
      end

      puts "NHANGARPROB: " + hangarcount.to_s
      puts "NWEAPONPROB: " + weaponcount.to_s
      puts "NSHIELDPROB: " + shieldcount.to_s
      puts "NFIRSTSHOTPROB: " + sscount.to_s
      puts "NMOVEPROB: " + movecount.to_s
    end
  end
  t1 = TestP1.new
  t1.main
end
