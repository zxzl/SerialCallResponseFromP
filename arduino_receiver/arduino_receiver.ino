const int dataNum = 10;

int index = 0;
int firstSlave = 4;
int rawData[dataNum] = { 0 };
int rawDataPrev[dataNum] = { 0 };
int i;

void setup()
{
  //I2C setup
  Wire.begin();
  //Serial setup
  Serial.begin(9600);
  Serial.setTimeout(50);
  establishContact();

}

void loop()
{
  if ( Serial.available() ) {
    // receives 10 number
    if(index == 0){
      for (index; index < dataNum; index ++)
      {
        rawData[index] = Serial.parseInt();
      }
    }
    // after succesfully receiving 10 data, 
    // update changed values to its slaves over I2C
    if (Serial.read() == '\n' && index == dataNum) {
      index = 0;      
      for (i = 0; i < dataNum; i++) {
        //do something with set of datas
      }
      //request new series of data by sending 'A'
      Serial.print('A');
      delay(10);
    }
    
  }
}

void establishContact() {
  // By sending 'A', arduino requires and waits for
  // a series of data from its partner over serial environemnt
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
