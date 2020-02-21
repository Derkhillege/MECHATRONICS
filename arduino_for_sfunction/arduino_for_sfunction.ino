/*
Preparation of communication with simulink, the board is continuesly waiting for input and responds to input of A, B, C or D:
'A': Return the name of the boat in ascii
181: Return RPM sensor data    rpm = 200n/dT and receive actuator data and send to boat
182: Reset actuators
'D': Return battery voltage
2010 Made by Andries van Wijhe, initiated by Joppe Buntsma.
*/
#include <Servo.h> 

byte inByte = 0;           // incoming serial byte
byte cByte = 0;            // incoming control byte
byte stime = 25;           // sample time in ms
Servo portaz;              // portside azimuth servo
Servo staraz;
Servo portthr;
Servo starthr;
Servo bowthr;
byte rpm[2];                //rpm sensor data
volatile int count[2];
unsigned long timeold[2];
byte i = 0;
byte j = 0;

void setup()
{
  // start serial port at 9600 bps:
  Serial.begin(9600);
  attachInterrupt(0, rpm_fun_port, RISING);        //pin 2
  attachInterrupt(1, rpm_fun_starboard, RISING);   //pin 3
  portaz.attach(4);       //servo at pin 7
  staraz.attach(5);
  portthr.attach(7);
  starthr.attach(8);
  bowthr.attach(6);
// add/change code here for Seabex one
  pinMode(13, OUTPUT);
}

void loop()
{
  
  if (Serial.available() > 0) {
    // get incoming switch byte:
    inByte = Serial.read();
    switch(inByte)
    {       
    case 181:   //mode B: write sensor values
    startover:
      rpm[0] = j;
      rpm[1] = 200 * count[j] / (millis() - timeold[j]);
      count[j] = 0;  //reset pulse counters
      timeold[j] = millis();
      i++;//transmit voltage once in a while
      i = i%20; 
      j = i%2;
      if (i ==2){
        rpm[0] = 2;
        rpm[1] = analogRead(A5)/4;}
        


      Serial.write(rpm,2);
      
      //wait for next byte to control portside azi
      while (Serial.available() == 0)    {delay(.1);}
      cByte = Serial.read();
      if (cByte<181){
        portaz.write(cByte);}
       else {goto startover;}
      
      //wait for next byte to control starboard azi servo
      while (Serial.available() == 0)    {delay(.1);}
      cByte = Serial.read();
      if (cByte<181){
      staraz.write(cByte);}
      else {goto startover;}
      
      //wait for next byte to control portside thruster
      while (Serial.available() == 0)    {delay(.1);}
      cByte = Serial.read();
      if (cByte<181){
      portthr.write(cByte);}
      else {goto startover;}
      
      //wait for next byte to control starboard thruster
      while (Serial.available() == 0)    {delay(.1);}
      cByte = Serial.read();
      if (cByte<181){
      starthr.write(cByte);} 
      else {goto startover;}
      
      //wait for next byte to control bow thruster
      while (Serial.available() == 0)    {delay(.1);}
      cByte = Serial.read();
      if (cByte<181){
      bowthr.write(1210+3*cByte);}
      else {goto startover;}
      break;  
          
      //mode D: get battery voltage
     case 'D':
       Serial.println(analogRead(A5),DEC);
       break;

       //mode A: print identity
     case 'A': 
      Serial.println(" Tugboat");
      Serial.println(" Tito Neri");
      break;
      
      //add/change code for seabex one
      
        //mode C: reset actuators, so after stopping the simulation all the engines will shut off
        // The servos will stay in the same place
     case 255:  
       bowthr.write(90);
       starthr.write(90);
       portthr.write(90);
       // add/change code for seabex one
       break;

        
   }//switch inbyte
 }//if byte available
else {
 if (analogRead(A5) < 614){//614 corresponds with 614/1024*10V=~6V
   digitalWrite(13,HIGH);}
 else {digitalWrite(13,LOW);}
}//else byte avaitable 
}//end void loop

//RPM counter interrupt functions
void rpm_fun_port() {count[0]++;}
void rpm_fun_starboard() {count[1]++;}




