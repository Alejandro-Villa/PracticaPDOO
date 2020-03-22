/**
 *
 * @author alejandro
 */
package deepspace;

public enum WeaponType {
    LASER(2.0f),
    MISSILE(3.0f),
    PLASMA(4.0f);
    
    private final float power;
    WeaponType(float pwr) {
        this.power = pwr;
    }
    
    float getPower() {
        return power;
    }
}
