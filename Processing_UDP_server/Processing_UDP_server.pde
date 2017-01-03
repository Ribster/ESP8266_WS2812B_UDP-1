/*

  This is Processing application to render and stream effect over UDP
  to the light devices. Right now the ESP8266 is supported.

  Author: Martin Hubacek
          martinhubacek.cz
          youtube.com/hubmartin
          @hubmartin
  
  License: MIT

*/

public class NetworkDevice
{
   public String ip;
   public int ledCount;
   public PVector positionOffset;
   public PVector positionIncrement;

   public NetworkDevice(String ip, int ledCount, int y)
   {
     this.ip = ip;
     this.ledCount = ledCount;
     this.positionOffset = new PVector(0,y);
     this.positionIncrement = new PVector(2,0);
   }
}

ArrayList<NetworkDevice> deviceList = new ArrayList<NetworkDevice>();


//
// Add new effect here, then add their string name to the <effects> element in data/config.xml
//
Effect[] effect = { new EffectPlasma(), new EffectDots(), new EffectSoundLevel() };


EffectManager em;





void setup() {
<<<<<<< HEAD
  size(900, 200);
  plasmaSetup();
  dotsInit();
  udpInit();

}

int effect = 1;
int increment = 0;
int moveup = 1;
int delaycounter = 0;

//process events
void draw() {
  NetworkDevice device = deviceList.get(0);
  switch(effect)
  {
   case 0:
    plasmaDraw();
    break;

    case 1:
    dotsDraw();
    break;

    case 2:
    //background(0);
    dotsDrawColor();
    break;

    case 3:
    background(255);
    break;

    case 4:
    background(255,0,0);
    break;

    case 5:
    background(0,255,0);
    break;

    case 6:
    background(0,0,255);
    break;

    case 7:
    // selected color
    break;

  }
  
  if(delaycounter++ == 5) {
    delaycounter = 0;
    
    if(increment == 1){
      if(device.positionOffset.x < width) device.positionOffset.x += 1;
    } else if (increment == 2){
      if(device.positionOffset.x > -(device.ledCount * device.positionIncrement.x)) device.positionOffset.x -= 1;
    } else if (increment == 3){
      if(device.positionOffset.x < width && moveup == 1){
        device.positionOffset.x += 1;
        moveup = 1;
      } else if (device.positionOffset.x > -(device.ledCount * device.positionIncrement.x)){
        device.positionOffset.x -= 1;
        moveup = 0;
      } else {
        moveup = 1;
      }
    }
    
      
  }

  
  
  
  udpSend();
=======
  
  // solve error libgles2-mesa
  // failed to open swrast
  // EGLGLXDrawableFactory
  size(900, 200, P2D);
  
  frameRate(25);
    
  // Init ESP UDP streaming
  espLibInit();
  
  em = new EffectManager(effect);
  
  em.init();
  
 
}

int actualEffect = 0;

//process events
void draw() {
  
  em.draw();

  espLibSend();
  
    //background(0);
  // draw the waveforms
  /*
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    stroke((1+in.left.get(i))*50,100,100);
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    stroke(white);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }*/
  
  
  
  
  //println(in.getGain());  
>>>>>>> 8e73b9cd1e4219a9d30a25e7e49c64fbf2f34d25
}


<<<<<<< HEAD
void effectNext()
{
 effect++;
}
=======
>>>>>>> 8e73b9cd1e4219a9d30a25e7e49c64fbf2f34d25



void colorSet(color c)
{
  actualEffect = 7;
  background(c);
}

void keyPressed()
{
 switch(key)
 {
    case '+':
    case 'a':
    em.next();
    break;
<<<<<<< HEAD

=======
    
    case '-':
>>>>>>> 8e73b9cd1e4219a9d30a25e7e49c64fbf2f34d25
    case 's':
    em.prev();
    break;

    case 'd':
    if(increment == 0){
      increment = 1;
    } else if (increment == 1){
      increment = 2;
    } else if (increment == 2){
      increment = 3;
    } else if (increment == 3){
      increment = 0;
    }
    break;
 }

 println("Effect number: " + effect);
 
  if(increment == 0){
    println("No scrolling");
  } else if (increment == 1){
    println("Led bar scrolling up");
  } else if (increment == 2){
    println("Led bar scrolling down");
  } else if (increment == 3){
    println("Led bar scrolling up/down");
  }
 
<<<<<<< HEAD
=======
 
>>>>>>> 8e73b9cd1e4219a9d30a25e7e49c64fbf2f34d25
}