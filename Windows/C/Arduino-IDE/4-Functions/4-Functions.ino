/*
  Functions

  Demonstrates the use of functions.
  Serial monitor must be started before run
*/

int a;int b;int z;

void setup() {
  Serial.begin(9600);
}

// the loop function runs over and over again forever
void loop() {
  a = random(100);
  b = random(100);
  z = calculate(a,b);
  // Write values
  Serial.print(a);
  Serial.print(" + ");
  Serial.print(b);
  Serial.print(" = ");
  Serial.println(z);
  delay(1000);
}

int calculate(int a,int b)
{
  return (a + b);
}
