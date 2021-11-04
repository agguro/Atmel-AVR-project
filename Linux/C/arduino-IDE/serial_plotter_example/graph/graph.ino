void setup() {
  // put your setup code here, to run once:
 Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int y1 = analogRead(A0);
  Serial.println(y1);
  delay(100);
}
