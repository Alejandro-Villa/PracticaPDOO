#encoding: UTF-8

require_relative "combat_result.rb"
require_relative "game_character.rb"
require_relative "shot_result.rb"
require_relative "WeaponType.rb"
require_relative "Loot.rb"
require_relative "SuppliesPackage.rb"
require_relative "ShieldBooster.rb"
require_relative "Weapon.rb"
require_relative "Dice.rb" 

require_relative "Hangar.rb"
require_relative "Damage.rb"
require_relative "EnemyStarShip.rb"
require_relative "SpaceStation.rb"
require_relative "GameUniverse.rb"

module Deepspace
  class TestP2
    def initialize
    end

    public

    def TestHangar
      puts "PRUEBA HANGAR"
      h = Hangar.new(2)
      puts h.inspect

      h2 = Hangar.newCopy(h)
      puts h2.inspect

      puts h.maxElements.to_s
      
      h.weapons.each { |w|
        puts w.inspect
      }

      h.shieldBoosters.each { |s|
        puts s.inspect
      }

      puts "Añadiendo arma"
      myweapon = Weapon.new("Ion Cannon", WeaponType::LASER, 1)
      if h.addWeapon(myweapon)
        puts "\tArma añadida con éxito"
      else
        puts "\tFallo al añadir arma"
      end

      puts "Ahora las armas son "
      h.weapons.each { |w| puts w.inspect }

      puts "Añadiendo escudo"
      myshield = ShieldBooster.new("Escudo1", 1.55, 1)

      if h.addShieldBooster myshield
        puts "\tPotenciador añadido correctamente"
      else
        puts "\tFallo al añadir potenciador"
      end

      puts "Ahora los shieldBooster son " 
      h.shieldBoosters.each { |s| puts s.inspect }

      puts "Borrando arma 0"
      w = Weapon.newCopy(h.removeWeapon 0)
      puts w.inspect

      puts "Borrando potenciador 0"
      s = ShieldBooster.newCopy(h.removeShieldBooster 0)
      puts s.inspect
    end

    def TestDamage
      puts "PRUEBA DAMAGE"

      d = Damage.newNumericWeapons(2, 2)
      puts d.inspect

      puts "Potenciadores perdidos: " + d.nShields.to_s
      puts "Armas perdidas: " + d.nWeapons.to_s
      puts "Tipos de armas perdidos"
      d.weapons.each { |t| puts t.to_s }

      puts "Copiando Damage"
      d2 = Damage.newCopy(d)
      puts d2.inspect

      puts "Damage con tipos específicos"
      specs = Array.new()
      specs.push(WeaponType::MISSILE)
      specs.push(WeaponType::LASER)
      d3 = Damage.newSpecificWeapons(specs, 2)
      d3.inspect

      puts "Potenciadores perdidos: " + d3.nShields.to_s
      puts "Armas perdidas: " + d3.nWeapons.to_s
      puts "Tipos de armas perdidos"
      d3.weapons.each { |t| puts t.to_s }

      puts "Descartando arma"
      w = Weapon.new("Nuclear Missile", WeaponType::LASER, 2)
      d.discardWeapon w
      puts d.inspect

      puts "Descartando Potenciador"
      s = ShieldBooster.new("potenciador genérico", 1.05, 1)
      d.discardShieldBooster s
      puts d.inspect

      if d.hasNoEffect
        puts "No tiene efecto"
      else 
        puts "Tiene efecto"
      end

      warr = Array.new
      warr.push w
      warr.push Weapon.new("Autocannon", WeaponType::PLASMA, 2)

      sbarr = Array.new
      sbarr.push s

      puts "Ajustando d"
      d.adjust(warr, sbarr)
      puts d.inspect
      puts "Ajustando d3"
      d3.adjust(warr, sbarr)
      puts d3.inspect

    end

    def TestEnemyStarShip
      puts "PROBANDO ENEMYSTARSHIP"
      
      l = Loot.new(1, 1, 1, 1, 1)
      d = Damage.newNumericWeapons(0,0)

      enemy = EnemyStarShip.new("BadGuy01", 1.5, 1.2, l, d)
      puts enemy.inspect

      puts "Copiando"
      copy =  EnemyStarShip.newCopy(enemy)
      puts copy.inspect

      puts "Disparo: " + enemy.fire.to_s
      puts "Proteccion: " + enemy.protection.to_s

      shot = 2.0
      if enemy.receiveShot(shot) == ShotResult::DONOTRESIST
        puts "No resiste"
      else
        puts "Si resiste"
      end
    end

    def TestSpaceStation
      puts "PROBANDO SPACESTATION"

      supp = SuppliesPackage.new(1.5, 2.0, 2.0)
      ss = SpaceStation.new("ISS", supp)
      puts ss.inspect

      puts "Recibiendo arma"
      w = Weapon.new("Plasma Cannon", WeaponType::PLASMA, 2)
      ss.receiveWeapon(w)

      puts "Recibiendo potenciador de escudo"
      s = ShieldBooster.new("Escudo02", 1.5, 2)
      ss.receiveShieldBooster(s)

      puts "Recibiendo Hangar"
      h = Hangar.new(2)
      ss.receiveHangar(h)

      puts "Descartando Hangar"
      ss.discardHangar

      puts "Configurando daño"
      d = Damage.newNumericWeapons(2, 2)
      ss.setPendingDamage(d)

      puts "Montando armas"
      ss.receiveHangar(h)
      ss.mountWeapon(0)

      puts "Montando potenciadores"
      ss.mountShieldBooster(0)
      
      puts "Recibiendo suministros"
      ss.receiveSupplies supp

      puts "Descartando armas y potenciadores"
      ss.discardWeaponInHangar 0
      ss.discardShieldBoosterInHangar 0
      ss.cleanUpMountedItems

      puts "Estado válido? " + ss.validState.to_s
      
      puts "Combustible antes: " + ss.fuelUnits.to_s
      puts "Nos movemos"
      ss.move
      puts "Combustible después: " + ss.fuelUnits.to_s
    end

    def TestGameUniverse
      puts "PRUEBA GAMEUNIVERSE"
      gu = GameUniverse.new()

      puts gu.inspect

      puts "Tenemos ganador?" + gu.haveAWinner.to_s

      i=0

      gu.mountShieldBooster i
      gu.mountWeapon i

      gu.discardHangar
      gu.discardShieldBooster i
      gu.discardShieldBoosterInHangar i
      gu.discardWeapon i
      gu.discardWeaponInHangar i

      puts "Status: " + gu.getState.to_s

    end
  end

  test = TestP2.new
  test.TestHangar
  test.TestEnemyStarShip
  test.TestSpaceStation
  test.TestGameUniverse
end

