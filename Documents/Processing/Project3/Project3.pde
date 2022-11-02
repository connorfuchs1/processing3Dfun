camera myCam = new camera();
float positionX= 0, positionY=0, positionZ=0, Phi, Theta, radius = 200, xPos, yPos;
PVector target = new PVector(10, 0, 10);
PShape cube, trianglefan6, trianglefan20, monster, wiremonster;
ArrayList<PVector> locations = new ArrayList<PVector>();
void setup() {
  size(1600, 1000, P3D);
  perspective(radians(50.0f), width/(float)height, 0.1, 1000);
  target.x = 100;
  target.y = -1;
  target.z = 1;

  cube = createShape();
  cube.beginShape(TRIANGLE);
  cube.fill(255, 255, 0);
  cube.vertex(.5, .5, .5);
  cube.vertex(-.5, .5, .5);
  cube.vertex(-.5, -.5, .5);
  cube.fill(0, 255, 0);
  cube.vertex(-.5, -.5, .5);
  cube.vertex(.5, .5, .5);
  cube.vertex(.5, -.5, .5);
  cube.fill(255, 255, 0);
  cube.vertex(-.5, -.5, .5);
  cube.vertex(-.5, -.5, -.5);
  cube.vertex(-.5, .5, .5);
  cube.fill(0, 0, 255);
  cube.vertex(-.5, .5, .5);
  cube.vertex(-.5, -.5, -.5);
  cube.vertex(-.5, .5, -.5);
  cube.fill(255, 165, 0); //top
  cube.vertex(-.5, -.5, .5);
  cube.vertex(-.5, -.5, -.5);
  cube.vertex(.5, -.5, .5);
  cube.fill(150);
  cube.vertex(.5, -.5, .5);
  cube.vertex(.5, -.5, -.5);
  cube.vertex(-.5, -.5, -.5);
  cube.fill(255, 0, 0);
  cube.vertex(.5, .5, .5);
  cube.vertex(.5, -.5, .5);
  cube.vertex(.5, .5, -.5);
  cube.fill(0, 0, 255);
  cube.vertex(.5, -.5, .5);
  cube.vertex( .5, -.5, -.5);
  cube.vertex(.5, .5, -.5);
  cube.fill(0, 255, 0);
  cube.vertex(-.5, -.5, -.5);
  cube.vertex(-.5, .5, -.5);
  cube.vertex(.5, .5, -.5);
  cube.fill(255, 0, 0);
  cube.vertex(-.5, -.5, -.5);
  cube.vertex(.5, .5, -.5);
  cube.vertex(.5, -.5, -.5);
  cube.fill(255, 165, 0); //bottom
  cube.vertex(-.5, .5, .5);
  cube.vertex(-.5, .5, -.5);
  cube.vertex(.5, .5, .5);
  cube.fill(150);
  cube.vertex(.5, .5, .5);
  cube.vertex(.5, .5, -.5);
  cube.vertex(-.5, .5, -.5);
  cube.endShape();

  colorMode(HSB, 360, 100, 100);
  trianglefan6 = createShape();
  trianglefan6.beginShape(TRIANGLE_FAN);

  for (int i = 0; i < 360; i+=60) {
    xPos =   cos(radians(i));
    yPos =    sin(radians(i));
    trianglefan6.fill(i, 100, 100);
    trianglefan6.vertex(xPos, yPos, 100);
  }
  trianglefan6.endShape();

  trianglefan20 = createShape();
  trianglefan20.beginShape(TRIANGLE_FAN);
  for (int i = 0; i < 360; i+=18) {
    xPos = cos(radians(i));
    yPos = sin(radians(i));

    trianglefan20.fill(i, 100, 100);

    trianglefan20.vertex(xPos, yPos, 100);
    
  }
 
  trianglefan20.endShape();


  colorMode(RGB, 255, 255, 255);

  monster = loadShape("monster.obj");
  wiremonster = loadShape("monster.obj");
  wiremonster.setFill(color(100, 100, 100, 0));
  wiremonster.setStroke(true);
  wiremonster.setStrokeWeight(2);

  //small cube
  myCam.AddLookAtTarget(new PVector(210, -10, 100));
  //medium cube
  myCam.AddLookAtTarget(new PVector(200, -10, 100));
  //big cube
  myCam.AddLookAtTarget(new PVector(190, -10, 100));

  //triangle fans
  myCam.AddLookAtTarget(new PVector(140, -10, 100));

  //monster
  myCam.AddLookAtTarget(new PVector(100, -10, 100));

  //wireframe monster
  myCam.AddLookAtTarget(new PVector(35, -10, 100));
}



void draw() {
  background(143, 188, 143);
  //drawing grid
  for (int x = 0; x<=200; x+=10) {
    for (int z = 0; z <= 200; z+=10) {
      line(x, 0, 0, x, 0, 200);
      line(0, 0, z, 200, 0, z);
    }
  }


  camera(positionX, positionY, positionZ, // Where is the camera?
    target.x, target.y, target.z, // Where is the camera looking?
    0, 1, 0); // Camera Up vector (0, 1, 0 often, but not always, works)

  translate(200, -10, 100);
  pushMatrix();
  scale(5, 5, 5);
  shape(cube);
  popMatrix();

  pushMatrix();
  translate(10, 0, 0);
  shape(cube);
  popMatrix();

  pushMatrix();
  translate(-10, 0, 0);
  scale(10, 20, 10);
  shape(cube);
  popMatrix();

  pushMatrix();
  translate(-60, 0, -500);
  scale(5, 5, 5);
  shape(trianglefan6);
  popMatrix();

  pushMatrix();
  translate(-40, 0, -500);
  scale(5, 5, 5);
  shape(trianglefan20);
  popMatrix();

  pushMatrix();
  translate(-100, 10, 0);
  scale(-.5);
  shape(monster);
  popMatrix();

  pushMatrix();

  translate(-170, 10, 0);
  scale(-1);
  shape(wiremonster);
  popMatrix();
  myCam.Update();
  if (keyCode == ' ') {
    myCam.CycleTarget();
    keyCode = DOWN;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  myCam.Zoom(e);
}

public class camera {
  int index = 0;
  void Update() {
    Phi = map(mouseX, 0, width-1, 0, 360);
    Theta = map(mouseY, 0, height-1, 1, 179);
    positionX = target.x + radius * cos(radians(Phi)) * sin(radians(Theta));
    positionY = target.y + radius * cos(radians(Theta));
    positionZ = target.z + radius * sin(radians(Theta)) * sin(radians(Phi));
  }
  void AddLookAtTarget(PVector target) {
    locations.add(target);
  }
  void CycleTarget() {
    if (index > locations.size() - 1) {
      index = 0;
      target.x = locations.get(index).x;
      target.y = locations.get(index).y;
      target.z = locations.get(index).z;
      index++;
    } else {
      target.x = locations.get(index).x;
      target.y = locations.get(index).y;
      target.z = locations.get(index).z;
      index++;
    }
  }
  void Zoom(float value) {

    if (radius + value > 300) {
      radius = 300;
    } else if ( radius + value < 10) {
      radius = 10;
    } else {
      radius = radius + value;
    }
  }
}
