int i = 0;
void setup() {
  pinMode(13, OUTPUT);
  Serial.begin(9600);
 }
void loop() {
   if (i < 360) {
    Serial.print(sin(radians(i)));
    Serial.print(',');
    Serial.println(cos(radians(i)));
    i++;
    delay(5);
   }
   else {
    i = 0;
   }
}
