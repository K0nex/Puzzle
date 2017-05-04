
import toxi.geom.*;
import processing.sound.*;
SoundFile fileBox;
SoundFile fileTriangle;

ArrayList<Box> gameObjects;
Box myBox1;
Box myBox2;

Triangle myTriangle;

Checker myChecker;
House myHouse;

void setup() {
  size(700, 700);

  myChecker = new Checker();
  myHouse = new House();

  gameObjects = new ArrayList<Box>();

  myBox1 = new Box(200, 200);
  myBox2 = new Box(400, 100);
  gameObjects.add(myBox1);
  gameObjects.add(myBox2);

  myTriangle = new Triangle(400, 200);
  gameObjects.add(myTriangle);

  fileBox= new SoundFile(this, "square.mp3"); //importerer filen fra "data". Filen stammer fra Oxford Dictionary
  fileTriangle= new SoundFile(this, "triangle.mp3"); //importerer filen fra "data". Filen stammer fra Oxford Dictionary
}

void draw() {   
  background(#00ECFF); //tyrkisblå

  myTriangle.check();
  myTriangle.display();
  myTriangle.teller();

  myBox1.check();
  myBox1.display();
  myBox1.teller();
  
  //myChecker.check();
  myHouse.display();

  if (sqrt(pow(abs(myHouse.x - myBox1.x), 2)+pow(abs(myHouse.y - myBox1.y), 2)) < 50)
    println("close");
  else println("not close");

  //myChecker.check();
  //myHouse.display();
}

void mousePressed() { //https://processing.org/examples/mousefunctions.html
  for (int i = 0; i < gameObjects.size(); i++) { //shmup
    Box obj = gameObjects.get(i);
    obj.xOffset = mouseX-obj.x; 
    obj.yOffset = mouseY-obj.y;
    if (obj.overBox) { 
      obj.locked = true; 
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