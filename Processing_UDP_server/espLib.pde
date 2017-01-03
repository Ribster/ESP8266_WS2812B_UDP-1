

// import UDP library
import hypermedia.net.*;
import mqtt.*;

UDP udp;  // define the UDP object
int port        = 8000;    // the destination port
<<<<<<< HEAD

MQTTClient client;
=======
    
MQTTClient mqttClient;
>>>>>>> 8e73b9cd1e4219a9d30a25e7e49c64fbf2f34d25

void mouseDragged()
{
  NetworkDevice device = deviceList.get(0);
  device.positionOffset.x = mouseX;
  device.positionOffset.y = mouseY;
}

<<<<<<< HEAD
void udpInit()
{
  udp = new UDP( this );
  //udp.listen( true );

  deviceList.add(new NetworkDevice("192.168.0.212", 300,0)); // obyvak
  //deviceList.add(new NetworkDevice("192.168.100.110", 267,0)); // obyvak
  //deviceList.add(new NetworkDevice("192.168.100.111", 216,5)); // jidelna
  // deviceList.add(new NetworkDevice("192.168.100.100", 216,5)); // sklep test

  //client = new MQTTClient(this);
  //client.connect("mqtt://192.168.100.131", "processing");
  //client.subscribe("/effect/#");

}

void messageReceived(String topic, byte[] payload) {

  if(topic.equals("/effect/next")) //<>// //<>//
    effectNext();

  if(topic.equals("/effect/prev"))
    effectPrev();

=======
void loadConfig()
{
  XML xml = loadXML("config.xml");
  

  //effectSet(xml.getInt("defaultEffect"));
  println("def eff:" + xml.getInt("defaultEffect"));
  
  XML[] mqtt = xml.getChildren("mqtt");
  if(mqtt.length > 0)
  {
    XML m = mqtt[0];
    mqttClient.connect(m.getString("address"), m.getString("name"));
    mqttClient.subscribe("/effect/#");
  }
  
  XML[] devices = xml.getChildren("devices");
  XML[] device = devices[0].getChildren("device"); //<>//
  
  println("Devices:" + device.length);
  
  for(XML d : device)
  {
    deviceList.add(new NetworkDevice(d.getString("address"), d.getInt("length") , d.getInt("y")));
  }
}
  
    
void espLibInit()
{
  udp = new UDP( this );
  mqttClient = new MQTTClient(this);
  
  loadConfig();
}

void messageReceived(String topic, byte[] payload) {
  
  if(topic.equals("/effect/next")) //<>//
    em.next();
    
  if(topic.equals("/effect/prev"))
    em.prev();
    
>>>>>>> 8e73b9cd1e4219a9d30a25e7e49c64fbf2f34d25
  if(topic.equals("/effect/set"))
  {
    em.set(Integer.parseInt(new String(payload)));
  }

  if(topic.equals("/effect/rgb"))
  {
    colorSet(unhex((new String(payload)).replace("#","")));
  }

  println("new message: ." + topic + ". - " + new String(payload));
}
<<<<<<< HEAD

void udpSend() //<>//
{

    for(NetworkDevice device : deviceList)
{

  color pix[] = new color[device.ledCount];

  for(int i = 0; i < pix.length; i++)
  {
      //pix[i] = pixels[i * 5];
      float x = device.positionOffset.x + device.positionIncrement.x * i;
      float y = device.positionOffset.y + device.positionIncrement.y * i;
      pix[i] = get((int)x, (int)y);
      //noFill();
      ellipse(x, y + 10, 2, 2);
  }

  sendData(device, pix);

=======
    
void espLibSend()
{
  
  
  for(NetworkDevice device : deviceList)
  {
  
    color pix[] = new color[device.ledCount];
     
    for(int i = 0; i < pix.length; i++)
    {
        //pix[i] = pixels[i * 5];
        float x = device.positionOffset.x + device.positionIncrement.x * i;
        float y = device.positionOffset.y + device.positionIncrement.y * i;
        //pix[i] = get((int)x, (int)y);
        pix[i] = pixels[(int)x + (int)y * width];
        
        //noFill();
        // Debug visualization of output LED strips
        //ellipse(x, y + 10, 2, 2);
    }
    
    sendData(device, pix);
  
>>>>>>> 8e73b9cd1e4219a9d30a25e7e49c64fbf2f34d25
  }

}

void sendData(NetworkDevice device, color[] dataPixels)
{


  byte header[] = new byte[] {0x01, ((byte)(dataPixels.length/256)), (byte)dataPixels.length};

  // RGB array
  byte data[] = new byte[dataPixels.length * 3];

  byte brightnessDiv = 10;

  for(int i = 0; i < dataPixels.length; i++)
  {
    color black = color(0,0,0);
    color srcColor = lerpColor(black,dataPixels[i] , .2);
    data[i*3 + 0] = ((byte)red(srcColor));
    data[i*3 + 1] = ((byte)green(srcColor));
    data[i*3 + 2] = ((byte)blue(srcColor));
  }

  byte[] byteSend = new byte[header.length + data.length];
  System.arraycopy(header, 0, byteSend, 0, header.length);
  System.arraycopy(data, 0, byteSend, header.length, data.length);

    udp.send( byteSend, device.ip , port );
}

/**
 * To perform any action on datagram reception, you need to implement this
 * handler in your code. This method will be automatically called by the UDP
 * object each time he receive a nonnull message.
 * By default, this method have just one argument (the received message as
 * byte[] array), but in addition, two arguments (representing in order the
 * sender IP address and his port) can be set like below.
 */
// void receive( byte[] data ) {       // <-- default handler
void receive( byte[] data, String ip, int port ) {  // <-- extended handler


  // get the "real" message =
  // forget the ";\n" at the end <-- !!! only for a communication with Pd !!!
  data = subset(data, 0, data.length-2);
  String message = new String( data );

  // print the result
  println( "receive: \""+message+"\" from "+ip+" on port "+port );
}