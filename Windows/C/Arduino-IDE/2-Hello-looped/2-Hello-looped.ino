/*
  Hello world

  Repeatedly print "Hello world." to the serial monitor.
  Serial monitor must be started before run
*/

void setup() {
  Serial.begin(9600);
}

// the loop function runs over and over again forever
void loop() {
  Serial.println("Hello, world!");
  delay(1000);
}
