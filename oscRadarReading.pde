/**
 * oscP5multicast by andreas schlegel
 * example shows how to send osc via a multicast socket.
 * what is a multicast? http://en.wikipedia.org/wiki/Multicast
 * ip multicast ranges and uses:
 * 224.0.0.0 - 224.0.0.255 Reserved for special �well-known� multicast addresses.
 * 224.0.1.0 - 238.255.255.255 Globally-scoped (Internet-wide) multicast addresses.
 * 239.0.0.0 - 239.255.255.255 Administratively-scoped (local) multicast addresses.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;

float velocity;
float range;

void setup() {
  size(400,400);
  background(0);
  frameRate(25);
  /* create a new instance of oscP5 using a multicast socket. */
  oscP5 = new OscP5(this,"2.0.0.1",9001);
}


void draw() {
  circleGrowth(); 
}


void mousePressed() {
  /* create a new OscMessage with an address pattern, in this case /test. */
  OscMessage myOscMessage = new OscMessage("/setMode");
  
  /* add a value (an integer) to the OscMessage */
  myOscMessage.add(1); // ID
  myOscMessage.add(0); // mode
  
  /* send the OscMessage to the multicast group. 
   * the multicast group netAddress is the default netAddress, therefore
   * you dont need to specify a NetAddress to send the osc message.
   */
  oscP5.send(myOscMessage);
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
    println(" typetag: "+theOscMessage.typetag());

  println(" ID         :" + theOscMessage.get(0).intValue());
  println(" Sensor     :" + theOscMessage.get(1).stringValue());
  println(" numTargets :" + theOscMessage.get(2).intValue());
  println(" velocity   :" + theOscMessage.get(3).floatValue());
  println(" range      :" + theOscMessage.get(4).floatValue());
  println(" signal     :" + theOscMessage.get(5).floatValue());
  
  // The only variables that matters
  velocity = theOscMessage.get(3).floatValue();
  range = theOscMessage.get(4).floatValue();
  
  
}

void circleGrowth () {
 ellipse(width/2,height/2, velocity*100, range*100); 
 fill(random(255),random(255),random(255)); 
  
}
