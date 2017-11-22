
#include <SoftwareSerial.h>
SoftwareSerial bluetoothSerial = SoftwareSerial(13,12);


void setup() {
  // put your setup code here, to run once:
    Serial.begin(115200);
    bluetoothSerial.begin(115200);
    while (!Serial) {}
    while (!bluetoothSerial) {}
}

void loop() {
  // put your main code here, to run repeatedly:
   if (Serial.available()) {
      char c = Serial.read();
      bluetoothSerial.print(c);
   }
   
   if (bluetoothSerial.available()) {
      char c = bluetoothSerial.read();
      Serial.print(c);
   }
}
