/**
 *
 * @author Alejandro Villanueva Prados
 */
package deepspace;

public class Weapon {
    private String name;
    private WeaponType type;
    private int uses;
    
    Weapon(String n, WeaponType t, int u) {
        name = n;
        type = t;
        uses = u;
    }
    
    Weapon(Weapon otro) {
        name = otro.name;
        type = otro.type;
        uses = otro.uses;
    }
    
    WeaponType getType() {
        return type;
    }
    
    int getUses() {
        return uses;
    }
    
    float power() {
        return type.getPower();
    }
    
    float useIt() {
        if (getUses() > 0)
            return power();
        else 
            return 1.0f;
    }
    
    @Override
    public String toString() {
        return "Weapon[" + "@" + System.identityHashCode(this) + ", " + name + ", " + getType() + ", " + getUses() + "]";
    }
}