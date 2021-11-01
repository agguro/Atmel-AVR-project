/*
  CircleArea

  Calculates the area of a circle.
  Serial monitor must be started before run
*/

void setup() {
  float area;
  Serial.begin(9600);
  // calculate the area of a circle with radius of 9.2
  float r=9.2;
  area = CircleArea(r);
  Serial.print("Area of circle is: ");
  // print area to 4 decimal places
  Serial.println(area, 4);
}

// the loop function runs over and over again forever
void loop() {
}

// calculate the area of a circle
float CircleArea(float radius)
{
  float result;
  const float pi = 3.14;
  result = pi * radius * radius;
  return result;
}
