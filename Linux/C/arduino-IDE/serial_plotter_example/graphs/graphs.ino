/*
 * Created by ArduinoGetStarted.com
 *
 * This example code is in the public domain
 *
 * Tutorial page: https://arduinogetstarted.com/tutorials/arduino-serial-plotter
 */

void setup() {
  Serial.begin(9600); 
}

void loop() {
  int y1 = analogRead(A0);
  int y2 = analogRead(A1);
  int y3 = analogRead(A2);
  int y4 = analogRead(A3);

  Serial.print(y1);
  Serial.print(" "); // a space ' ' or  tab '\t' character is printed between the two values.
  Serial.print(y2);
  Serial.print(" "); // a space ' ' or  tab '\t' character is printed between the two values.
  Serial.print(y3);
  Serial.print(" "); // a space ' ' or  tab '\t' character is printed between the two values.
  Serial.println(y4); // the last value is followed by a carriage return and a newline characters.

  delay(100);
}
