
#define LIN_OUT 1 // use the lin output function

#define FFT_N 32 // set number of point fft



#include "FFT.h" // include the library

#include 





volatile int i;    // index for data points





void timerIsr()

{

  while(!(ADCSRA & 0x10)); // wait for adc to be ready

  ADCSRA = 0xf5; // restart adc

  byte m = ADCL; // fetch adc data

  byte j = ADCH;

  int k = (j << 8) | m; // form into an int

  k -= 0x0200; // form into a signed int

  k <<= 6; // form into a 16b signed int

  fft_input[i] = k; // put real data into even bins

  fft_input[i+1] = 0; // set odd bins to 0

  i += 2;

}





void setup() {

  Serial.begin(115200); // use the serial port

  TIMSK0 = 0; // turn off timer0 for lower jitter

  ADCSRA = 0xe5; // set the adc to free running mode

  ADMUX = 0x40; // use adc0

  DIDR0 = 0x01; // turn off the digital input for adc0

  

  i = 0;



  Timer1.initialize(1000); // set a timer of length 100 microseconds (10000Hz)

  Timer1.attachInterrupt( timerIsr ); // attach the service routine here

}



void loop() {

  while(i < FFT_N*2) {

  }



  cli();  // UDRE interrupt slows this way down on arduino1.0

  fft_window(); // window the data for better frequency response

  fft_reorder(); // reorder the data before doing the fft

  fft_run(); // process the data in the fft

  fft_mag_lin(); // take the output of the fft

  i = 0;

  for (int l=0; l<FFT_N/2; l++){

    Serial.print(fft_lin_out[l]); // send out the data

    Serial.print(",");

  }

  Serial.println();    

  sei();

}

