
/**
 *
 * @author Alejandro Villanueva Prados
 */
package deepspace;

public class ShieldBooster {
    private String name;
    private float boost;
    private int uses;
    
    ShieldBooster(String n, float b, int u) {
        name = n;
        boost = b;
        uses = u;
    }
    
    ShieldBooster(ShieldBooster otro) {
        name = otro.name;
        boost = otro.boost;
        uses = otro.uses;
    }
    
    float getBoost() {
        return boost;
    }
    
    int getUses() {
        return uses;
    }
    
    float useIt() {
        if(getUses() > 0) {
            uses--;
            return getBoost();
        }
        else
            return 1.0f;
    }
    
    /* Gracias a esta sobrecarga, obtenemos mucha información sobre el objeto, 
    sobre todo para comparar que estamos realizando la copia correctamente */
    @Override
    public String toString() {
        return "ShieldBooster[" + "@" + System.identityHashCode(this) + ", " + name + ", " + getBoost() + ", " + getUses() + "]";
    }
}
