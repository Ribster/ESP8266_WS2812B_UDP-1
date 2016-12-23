/*
http://pixelinvaders.ch/?page_id=160
http://www.live-leds.de/features/ Jinx! – LED Matrix Control
http://www.lightjams.com/sacn.html
http://www.lightjams.com/getIt.html


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



void setup() {
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
}

void colorSet(color c)
{
  effect = 7;
  background(c);
}

void effectNext()
{
 effect++;
}

void effectPrev()
{
  effect--;
}

void effectSet(int i)
{
  effect = i;
}

void keyPressed()
{
 switch(key)
 {
    case 'a':
    effect++;
    break;

    case 's':
    effect--;
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
 
}