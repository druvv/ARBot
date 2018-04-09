#include <vexMotor.h>

/*

*/

#include <Servo.h>
#include <SoftwareSerial.h>

char incomingChar;
const char END_COMMAND_CHAR = '\n';
String serialBuffer = "";

vexMotor motorFL;
vexMotor motorFR;
vexMotor motorBL;
vexMotor motorBR;

SoftwareSerial bluetoothSerial = SoftwareSerial(13,12);
const int STATE_PIN = 11;

void setup() {
    // Setup state pin to check if we are connected
    pinMode(STATE_PIN,INPUT);
    
    motorFL.attach(2);
    motorFR.attach(3);
    motorBL.attach(4);
    motorBR.attach(5);
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
  // If we are not connected to bluetooth stop the robot
  if (digitalRead(STATE_PIN) == LOW) {
    stopMoving();
    return;
  }

  
  // If there is a character to read
  if (Serial.available() > 0 ) {
     incomingChar = Serial.read();
     handleChar(incomingChar);
  } else if (bluetoothSerial.available() > 0) {
     incomingChar = bluetoothSerial.read();
     handleChar(incomingChar);
  }
}

void stopMoving() {
  motorFL.write(motorFL.getZeroPoint());
  motorFR.write(motorFR.getZeroPoint());
  motorBL.write(motorBL.getZeroPoint());
  motorBR.write(motorBR.getZeroPoint());
  announce("Stopping!");
}

void handleChar(char c) {
  // If we reach the end of the command execute the command
  if (c == END_COMMAND_CHAR) {
    executeCommand();
    return;
  }
  // Append to buffer
  serialBuffer += c;
}

void executeCommand() {

  /* Command Protocol
      <leftSpeed>/<rightSpeed>\n
      -256 means continue with old speed
  */
  
  // Get left and right speeds
  int i = serialBuffer.indexOf("/");
  String leftString = serialBuffer.substring(0,i);
  String rightString = serialBuffer.substring(i+1);
  int leftSpeed = leftString.toInt();
  int rightSpeed = rightString.toInt();

  

  // Set motor speeds
  if (leftSpeed != -256) {
     motorFL.write(leftSpeed);
     motorBL.write(leftSpeed);
  }

  if (rightSpeed != -256) {
    motorFR.write(rightSpeed);
    motorBR.write(rightSpeed);
  }
  

  // Clear Serial Buffer
  serialBuffer = "";
}

