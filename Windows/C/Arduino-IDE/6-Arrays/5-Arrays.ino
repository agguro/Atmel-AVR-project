/*
  Arrays

  Demonstration of arrays
  Serial monitor must be started before run
*/
  const int arraysize = 100;
  int x;
  int sum = 0;
  float average = 0;
  int myarray[arraysize];
void setup() 
{ 
  Serial.begin(9600);
}
void loop()
{ 
  sum = 0; 
  for (int i = 0; i < arraysize; i++) 
  { 
    x = random(200); 
    myarray[i] = x; 
  } 
  sum = calculateSum(myarray); 
  average = sum / 100; 
  Serial.print(" Sum = "); 
  Serial.print(sum); 
  Serial.print(" , Average = "); 
  Serial.println(average); 
  delay(1000);
}

int calculateSum (int sumarray[])
{ 
  for (int i = 0; i < arraysize; i++) 
  { 
    sum = sum + sumarray[i]; 
  } 
  return sum;
}
