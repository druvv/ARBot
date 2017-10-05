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

void setup() {
    servo.attach(5);
    Serial.begin(9600);
    bluetoothSerial.begin(9600);
    while (!Serial) {}
    while (!bluetoothSerial) {}
}

void loop() {
    if (Serial.available() > 0 ) {
       incomingChar = Serial.read();
       handleChar(incomingChar);
    } else if (bluetoothSerial.available() > 0) {
       incomingChar = bluetoothSerial.read();
       handleChar(incomingChar);
    }
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
    Serial.println(sub);
    int servoSpeed = sub.toInt();
    servo.write(servoSpeed);
  }

  // Clear Serial Buffer
  serialBuffer = "";
  
}

