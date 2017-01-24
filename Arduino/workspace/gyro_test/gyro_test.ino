//********************************
//加速度センサの値を取得するプログラム
//********************************
unsigned long time;
int k;

void setup()
{
  // シリアルモニターの初期化をするgyr
  Serial.begin(9600) ;
}
void loop()
{ 
  time = micros();

  long x , y , z ;
  
  x = y = z = 0 ;

  for (int i=0;i<50;i++){
  x = x + analogRead(3) ; // Ｘ軸
  y = y + analogRead(4) ; // Ｙ軸
  z = analogRead(5) ; // Ｚ軸
  }

  y = analogRead(4) ; // Ｙ軸
  //y = y/50;
  k = k+1;

  //Serial.print(time*0.001);
  //Serial.print(',');
  //Serial.println(k);
  //Serial.print(',');
  Serial.print(y);
  Serial.print(',');
  Serial.println(z);
  
  
  /*Serial.print("X:") ;
  Serial.print(x) ;
  Serial.print(" Y:") ;
  Serial.print(y) ;
  Serial.print(" Z:") ;
  Serial.println(z) ;*/
  delay(0) ;
}
