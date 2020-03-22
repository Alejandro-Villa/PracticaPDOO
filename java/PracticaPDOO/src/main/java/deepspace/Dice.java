/**
 *
 * @author Alejandro Villanueva Prados
 */
package deepspace;

public class Dice {
    private final float NHANGARSPROB;
    private final float NSHIELDSPROB;
    private final float NWEAPONSPROB;
    private final float FIRSTSHOTPROB;
    private java.util.Random generator;
    
    Dice() {
        NHANGARSPROB = 0.25f;
        NSHIELDSPROB = 0.25f;
        NWEAPONSPROB = 0.33f;
        FIRSTSHOTPROB = 0.5f;
        
        generator = new java.util.Random();
    }
    
    int initWithNHangars() {
        if(generator.nextFloat() > NHANGARSPROB)
            return 1;
        else 
            return 0;
    }
    
    int initWithNWeapons() {
        float prob = generator.nextFloat();
        if( prob < NWEAPONSPROB)
            return 1;
        else if( prob < 2*NWEAPONSPROB)
            return 2;
        else 
            return 3;
    }
    
    int initWithNShields() {
        if(generator.nextFloat() > NHANGARSPROB)
            return 1;
        else 
            return 0;
    }
    
    int whoStarts(int nPlayers) {
        return generator.nextInt(nPlayers);
    }
    
    GameCharacter firstShot() {
        if(generator.nextFloat() > FIRSTSHOTPROB)
            return GameCharacter.ENEMYSTARSHIP;
        else 
            return GameCharacter.SPACESTATION;
    }
    
    Boolean spaceStationMoves(float speed) {
        return generator.nextFloat() <= speed;
    }
}