/*
  ForLoop

  Demonstration of a For Next Loop
  It generates 100 random values and calculates the sum and the
  average.
  Serial monitor must be started before run
*/
int x; int sum = 0; float average = 0.0;

void setup() {
  Serial.begin(9600);
}

// the loop function runs over and over again forever
void loop() {
  sum = 0;
  for(int i = 0; i < 100; i++){
    x = random(100);
    sum = sum + x;    
  }
  average = sum / 100;
  Serial.print("  Sum = ");
  Serial.print(sum);
  Serial.print(" , Average = ");
  Serial.println(average);
  delay(1000);
}
