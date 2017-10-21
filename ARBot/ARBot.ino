/*

*/

#include <Servo.h>
#include <SoftwareSerial.h>

char incomingChar;
const char endCommandChar = '\n';
String serialBuffer = "";
/* Commands
 *  setSpeed: - Sets the servo to the indicated speed
 */

Servo servo;
SoftwareSerial bluetoothSerial = SoftwareSerial(7,8);
// 7 Tx
// 8 Rx

int statePin = 2;

void setup() {
    // Setup state pin to check if we are connected
    pinMode(statePin,INPUT);
    
    servo.attach(5);
    Serial.begin(115200);
    bluetoothSerial.begin(115200);
    while (!Serial) {}
    while (!bluetoothSerial) {}
}

void announce(String s) {
  bluetoothSerial.println(s);
  Serial.println(s);
}

void loop() {
  // If we are not connected
  if (digitalRead(statePin) == LOW) {
    stopMoving();
    return;
  }
  
  if (Serial.available() > 0 ) {
     incomingChar = Serial.read();
     handleChar(incomingChar);
  } else if (bluetoothSerial.available() > 0) {
     incomingChar = bluetoothSerial.read();
     handleChar(incomingChar);
  }
}

void stopMoving() {
  servo.write(95);
}

void handleChar(char c) {
  // If we reach the end of the command execute the command
  if (c == endCommandChar) {
    executeCommand();
    return;
  }
  // Append to buffer
  serialBuffer += c;
}

void executeCommand() {

  // Set the speed of the servo
  if (serialBuffer.indexOf("setSpeed:") != -1) {
    String sub = serialBuffer.substring(9);
    int servoSpeed = sub.toInt();
    String s = "Servo Speed set to: ";
    s.concat(servoSpeed);
    announce(s);
    servo.write(servoSpeed);
  }

  // Clear Serial Buffer
  serialBuffer = "";
}

