/**
 *
 * @author Alejandro Villanueva Prados
 */
package deepspace;

public class SuppliesPackage {
   private float ammoPower;
   private float fuelUnits;
   private float shieldPower;
   
   SuppliesPackage(float a, float f, float s) {
       ammoPower = a;
       fuelUnits = f;
       shieldPower = s;
   }
   
   SuppliesPackage(SuppliesPackage otro) {
       ammoPower = otro.ammoPower;
       fuelUnits = otro.fuelUnits;
       shieldPower = otro.shieldPower;
   }
   
   float getAmmoPower() {
       return ammoPower;
   }
   
   float getFuelUnits() {
       return fuelUnits;
   }
   
   float getShieldPower() {
       return shieldPower;
   }
   
   /* Gracias a esta sobrecarga, obtenemos mucha información sobre el objeto, 
    sobre todo para comparar que estamos realizando la copia correctamente */
   @Override
   public String toString() {
       return "SuppliesPackage[" + "@" + System.identityHashCode(this) + getAmmoPower() + ", " + getFuelUnits() + ", " + getShieldPower() + "]";
   }
}
