/**
 *
 * @author Alejandro Villanueva Prados
 */
package deepspace;

public class Loot {
    private int nSupplies;
    private int nWeapons;
    private int nShields;
    private int nHangars;
    private int nMedals;
    
    Loot(int supplies, int weapons, int shields, int hangars, int medals) {
        nSupplies = supplies;
        nWeapons = weapons;
        nShields = shields;
        nHangars = hangars;
        nMedals = medals;
    }
    
    int getNSupplies() {
        return nSupplies;
    }
    
    int getNWeapons() {
        return nWeapons;
    }
    
    int getNShields() {
        return nShields;
    }
    
    int getNHangars() {
        return nHangars;
    }
    
    int getNMedals() {
        return nMedals;
    }
}
