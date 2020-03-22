/**
 *
 * @author Alejandro Villanueva Prados
 */
package deepspace;

public class TestP1 {
    public static void main(String[] args) {
        // Probamos la clase Loot, creando una instancia suya
        System.out.println("Prueba Loot");
        Loot botin = new Loot(1,2,3,4,5);
        // Veamos si funcionan los consultores
        System.out.println("Suministros: " + botin.getNSupplies());
        System.out.println("Armas: " + botin.getNWeapons());
        System.out.println("Escudos: " + botin.getNShields());
        System.out.println("Hangares: " + botin.getNHangars());
        System.out.println("Medallas: " + botin.getNMedals());
        
        System.out.println("===========================================");
        // Probamos la clase SuppliesPackage, creando una instancia suya
        System.out.println("Prueba SuppliesPackage");
        SuppliesPackage supppkg = new SuppliesPackage(0.5f, 1.5f, 2.2f);
        // Probamos el constructor de copia
        SuppliesPackage otro = new SuppliesPackage(supppkg);
        System.out.println(supppkg.toString() + " == " + otro.toString());
        // Probamos los consultores
        System.out.println("Munición: " + supppkg.getAmmoPower());
        System.out.println("Combustible: " + supppkg.getFuelUnits());
        System.out.println("Escudo: " + supppkg.getShieldPower());
        
        System.out.println("===========================================");
        // Probamos la clase ShieldBooster, creando una instancia suya
        System.out.println("Prueba ShieldBooster");
        ShieldBooster shield = new ShieldBooster("Escudo1", 1.55f, 1);
        // Probamos el constructor de copia.
        ShieldBooster otroshield = new ShieldBooster(shield);
        // Probamos los consultores
        System.out.println(shield.toString() + " == " + otroshield.toString());
        System.out.println("Boost: " + shield.getBoost());
        System.out.println("Usos: " + shield.getUses());
        // Probamos useIt.
        System.out.println("Usando... el boost es: " + shield.useIt());
        System.out.println("Usando de nuevo, ahora: " + shield.useIt());
        
        System.out.println("===========================================");
        // Probamos la clase Weapon, creando una instancia suya
        System.out.println("Prueba Weapon");
        Weapon wp = new Weapon("Ion Cannon", WeaponType.LASER, 1);
        // Probamos el constructor de copia
        Weapon copy = new Weapon(wp);
        System.out.println(wp.toString() + " == " + copy.toString());
        // Probamos los consultores
        System.out.println("Tipo: " + wp.getType());
        System.out.println("Usos: " + wp.getUses());
        // Probamos el método power()
        System.out.println("Power: " + wp.power());
        // Ahora probamos useIt()
        System.out.println("Usamos el arma, potencia: " + wp.useIt());
        System.out.println("De nuevo, ahora: " + wp.useIt());
        
        System.out.println("===========================================");
        // Probamos la clase Dice, creando una instancia suya
        System.out.println("Prueba Dice");
        Dice dado = new Dice();
        
        int hangarcount = 0;
        int weaponcount = 0;
        int shieldcount = 0;
        int shotcount = 0;
        int movecount = 0;
        for (int i = 0; i < 100; ++i) {
            if (dado.initWithNHangars() == 0)
                hangarcount++;
            if (dado.initWithNWeapons() == 1)
                weaponcount++;
            if (dado.initWithNShields() == 0)
                shieldcount++;
            if (dado.firstShot() == GameCharacter.SPACESTATION)
                shotcount++;
            if (dado.SpaceStationMoves(0.5) == true)
                movecount++;
        }
        
        System.out.println("NHANGARPROB: " + hangarcount);
        System.out.println("NWEAPONPROB: " + weaponcount);
        System.out.println("NSHIELDPROB: " + shieldcount);
        System.out.println("NFIRSTSHOTPROB: " + shotcount);
        System.out.println("NMOVEPROB: " + movecount);
        
    }
}
