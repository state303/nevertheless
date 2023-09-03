import org.openkinect.processing.*;
import codeanticode.syphon.*;
import java.util.ArrayList;

private final int instanceCount = 2;
private ArrayList<Kinectv2> kinects;
private SyphonServer server;

private Kinect2 getInstance() {
  Kinect2 instance = new Kinect2(this);
  instance.initDepth();
  instance.initVideo();
  instance.initIR();
  return instance;
}

// create n instances, initialize them each, then return the consolidated list.
private ArrayList<Kinectv2> initInstances(int n) {
  ArrayList<Kinectv2> items = new ArrayList<>();
  for (int i = 0; i < n; i++) {
    Kinectv2 instance = getInstance();
    instance.initDevice(i);
    items.add(instance);
  }
  return items;
}

// draw with two kinects from the given kinects list.
private void drawTwoKinects(ArrayList<Kinectv2> kinects) {
  background(0);
  pushMatrix();
  translate(0, height/2);
  scale(1, -1);
  translate(0, -height/2);
  image(kinect2a.getIrImage(), +2, +454);
  popMatrix();

  pushMatrix();
  scale(-1.0,1.0);
  translate(-width, 0);
  image(kinect2b.getIrImage(), 0, 325);
  popMatrix();
  
}

void setup() {
  size(512, 848, P2D);
  
  //Start tracking each kinect
  initInstances(INSTANCE_COUNT);
  server = new SyphonServer(this, "KinectIR");
  
  background(0);
}

void draw() {
  drawTwoKinects(kinects);
  server.sendScreen();
}
