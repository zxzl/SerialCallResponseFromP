import processing.serial.*;
import controlP5.*;
//used controlP5 library to make toggle and slider, 
//please install it before running this file
//(http://www.sojamo.de/libraries/controlP5/)

Serial myPort;
int dataNum = 10;

// values to be transmitted to Arudino
int[] outputArray = new int[dataNum];

// In this sample code, I will use 10 gui elements to adjust data to be transmitted
// ControlP5 Object
ControlP5 cp5;
// variables for GUI elements
int toggle1, toggle2, toggle3, toggle4, toggle5;
int slider1, slider2, slider3, slider4, slider5;



void setup() {
  size(600, 600);

  //serial setup
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[2], 9600);
  
  //gui library setup
  cp5 = new ControlP5(this);
  
  //create toggles for digital output
  cp5.addToggle("toggle1").setPosition(20, 100).setSize(50,20);
  cp5.addToggle("toggle2").setPosition(80, 100).setSize(50,20);
  cp5.addToggle("toggle3").setPosition(140, 100).setSize(50,20);
  cp5.addToggle("toggle4").setPosition(200, 100).setSize(50,20);
  cp5.addToggle("toggle5").setPosition(260, 100).setSize(50,20);
  
  //create sliders for analog output
  cp5.addSlider("slider1").setPosition(20,150).setRange(0,255);
  cp5.addSlider("slider2").setPosition(20,170).setRange(0,255);
  cp5.addSlider("slider3").setPosition(20,190).setRange(0,255);
  cp5.addSlider("slider4").setPosition(20,210).setRange(0,255);
  cp5.addSlider("slider5").setPosition(20,230).setRange(0,255);
  

  
}

void draw() {
  background(120);
  
  //copy slider values to output array
  outputArray[0] = slider1;
  outputArray[1] = slider2;
  outputArray[2] = slider3;
  outputArray[3] = slider4;
  outputArray[4] = slider5;
  //copy toggle values to output array
  outputArray[5] = toggle1;
  outputArray[6] = toggle2;
  outputArray[7] = toggle3;
  outputArray[8] = toggle4;
  outputArray[9] = toggle5;
}

void serialEvent(Serial myPort) {
  // every time the code gets 'A' via serial, 
  // it sends 10 values which are seperated by " "(blank) and terminated by "\n"
  if (myPort.read() == 'A') {
      myPort.clear();
      for (int i = 0; i < dataNum - 1; i++) {
        myPort.write(outputArray[i] + " ");
      }
      myPort.write(outputArray[dataNum - 1] + "\n");
  }
}
      
