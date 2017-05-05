
import toxi.geom.*;
import processing.sound.*;
SoundFile fileBox;
SoundFile fileTriangle;

boolean boxHome = false;
boolean triangleHome = false;

ArrayList<Box> gameObjects;
Box myBox1;
Triangle myTriangle1;
House myHouse;

void setup() {
  size(700, 700);

  myHouse = new House();

  gameObjects = new ArrayList<Box>();

  myBox1 = new Box(200, 200);
  gameObjects.add(myBox1);

  myTriangle1 = new Triangle(400, 200);
  gameObjects.add(myTriangle1);

  fileBox= new SoundFile(this, "square.mp3"); //importerer filen fra "data". Filen stammer fra Oxford Dictionary http://www.oxfordlearnersdictionaries.com/media/english/uk_pron/s/squ/squar/square__gb_1.mp3
  fileTriangle= new SoundFile(this, "triangle.mp3"); //importerer filen fra "data". Filen stammer fra Oxford Dictionary http://www.oxfordlearnersdictionaries.com/media/english/uk_pron/t/tri/trian/triangle__gb_2.mp3
}

void draw() {   
  background(#00ECFF); //tyrkisblå

  myHouse.display();

  myBox1.check();
  myBox1.display();
  myBox1.teller();

  myTriangle1.check();
  myTriangle1.display();
  myTriangle1.teller();

  if (sqrt(pow(abs(myHouse.x - myBox1.x), 2)+pow(abs(myHouse.y-80 - myBox1.y), 2)) < 10) {
    boxHome = true;
    if (sqrt(pow(abs(myHouse.x-80 - myTriangle1.x), 2)+pow(abs(myHouse.y-150 - myTriangle1.y), 2)) < 10) {
      triangleHome = true;
    }
  }

  if (boxHome==true && triangleHome==true) {
    pushStyle();
    textSize(100);
    fill(0);
    textAlign(CENTER);
    text("Godt klaret", width/2, height/4);
    popStyle();
  }
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