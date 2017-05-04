
import toxi.geom.*;
import processing.sound.*;
SoundFile file;

ArrayList<Box> gameObjects;
Box myBox1;
Box myBox2;

//ArrayList<Triangle> gameObejcts;
Triangle myTriangle;

House myHouse;

Checker myChecker;

void setup() {
  size(700, 700);

myChecker = new Checker();

  myHouse = new House();

  gameObjects = new ArrayList<Box>();

  myBox1 = new Box(200, 200);
  myBox2 = new Box(400, 100);
  gameObjects.add(myBox1);
  gameObjects.add(myBox2);

  //gameObjects = new ArrayList<Triangle>();
  myTriangle = new Triangle(400, 200);
  gameObjects.add(myTriangle);

  file= new SoundFile(this, "square1.mp3"); //importerer filen fra "data". Filen stammer fra Cambridge Dictionary

  fill(153);
}

void draw() {   
  background(#00ECFF); //tyrkisblå
  
  if (sqrt(pow(abs(myHouse.x - myBox1.x),2)+pow(abs(myHouse.y - myBox1.y),2)) < 100)
    println("close");
    else println("not close");

  myTriangle.check();
  myTriangle.display();
  
  //stroke(0);

  myBox1.check();
  myBox1.display();

  myBox2.check();
  //myBox2.display();

myChecker.check();

  myHouse.display();
}

void mousePressed() { //https://processing.org/examples/mousefunctions.html
  for (int i = 0; i < gameObjects.size(); i++) { //shmup
    Box obj = gameObjects.get(i);
    obj.xOffset = mouseX-obj.x; 
    obj.yOffset = mouseY-obj.y;
    if (obj.overBox) { 
      obj.locked = true; 
      file.play();
      return;
    } else {
      
      obj.locked = false;
    }
  }
}

void mouseDragged() { //https://processing.org/examples/mousefunctions.html
  for (int i = 0; i < gameObjects.size(); i++) {
    Box obj = gameObjects.get(i);
    if (obj.locked) {
      obj.x = mouseX-obj.xOffset; 
      obj.y = mouseY-obj.yOffset;
    }
  }
}

void mouseReleased() { //https://processing.org/examples/mousefunctions.html
  for (int i = 0; i < gameObjects.size(); i++) {
    Box obj = gameObjects.get(i);
    obj.locked = false;
  }
}