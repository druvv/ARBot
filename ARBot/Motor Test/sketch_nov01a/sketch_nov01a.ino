#include <vexMotor.h>

#include <Servo.h>  

vexMotor motor1;

void setup() {
  // put your setup code here, to run once:
  motor1.attach(2);
  Serial.begin(9600);
  

}

void loop() {
  // put your main code here, to run repeatedly:
  motor1.write(0);
  delay(1000);
  motor1.write(128);
  delay(1000);

}


