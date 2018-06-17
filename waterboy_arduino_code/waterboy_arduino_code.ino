/* determine scale factor
 *  this code is based on the awesome work of
 *  https://github.com/bogde/HX711
 * you need to get above code and import it to arduino for this script
*/
#include "HX711.h"
 
#define DL  15
#define SCK  14
 
HX711 scale(DL, SCK);
 
float calibration_factor = 1965550.00; // this is for my 1kg loadcell 

void setup() {
  Serial.begin(9600);
  Serial.println("HX711 Calibration");
  Serial.println("Remove all weight from scale");
  Serial.println("After readings begin, place known weight on scale");
  Serial.println("Press a,s,d,f to increase calibration factor by 10,100,1000,10000 respectively");
  Serial.println("Press z,x,c,v to decrease calibration factor by 10,100,1000,10000 respectively");
  Serial.println("Press t for tare");
  scale.set_scale();
  scale.tare(); //Reset the scale to 0
 
  long zero_factor = scale.read_average(); //Get a baseline reading
  Serial.print("Zero factor: "); //This can be used to remove the need to tare the scale. Useful in permanent scale projects.
  Serial.println(zero_factor);

  pinMode(3,OUTPUT);
  pinMode(4,OUTPUT);
}
 
void pump_on(){
    digitalWrite(3, HIGH);
    digitalWrite(4, LOW);
}

void pump_off(){
    digitalWrite(3, LOW);
    digitalWrite(4, LOW);
}

void loop() {
  scale.set_scale(calibration_factor);
 
  Serial.print("Reading: ");
  Serial.print(scale.get_units(), 3);
  Serial.print(" kg");
  Serial.print(" calibration_factor: ");
  Serial.print(calibration_factor);
  Serial.println();
 
  if(Serial.available()){
    char temp = Serial.read();
    if(temp == '+' || temp == 'a')
      calibration_factor += 10;
    else if(temp == '-' || temp == 'z')
      calibration_factor -= 10;
    else if(temp == 's')
      calibration_factor += 100;  
    else if(temp == 'x')
      calibration_factor -= 100;  
    else if(temp == 'd')
      calibration_factor += 1000;  
    else if(temp == 'c')
      calibration_factor -= 1000;
    else if(temp == 'f')
      calibration_factor += 10000;  
    else if(temp == 'v')
      calibration_factor -= 10000;  
    else if(temp == 't')
      scale.tare();  //Reset the scale to zero
  }

  if(scale.get_units() > 0.3 && scale.get_units() < 0.7){
    pump_on();
  }else{
    pump_off();
  }
}
