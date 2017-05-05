
class Box {
  float x;
  float y;
  int boxSize = 80;
  boolean overBox = false;
  boolean locked = false;
  boolean presBox = false;
  boolean soundTriggered = false;
  float xOffset = 0.0; 
  float yOffset = 0.0;

  Box() {
    x = width/2.0;
    y = height/2.0-100;
  }

  Box(float setx, float sety) {
    x = setx;
    y = sety;
  }

  void check() { 
    // Test if the cursor is over the box (https://processing.org/tutorials/interactivity/)
    if (mouseX > x-boxSize && mouseX < x+boxSize && 
      mouseY > y-boxSize && mouseY < y+boxSize) {
      overBox = true;  
      if (!locked) {  
        stroke(255); 
        fill(153);
      }
    } else {
      noStroke();
      overBox = false;
    }
  }

  void display() {
    rectMode(RADIUS);
    if (overBox && locked) {
      fill(255);
    } else {
      fill(153);
    }
    if (boxHome==true) {
      fill(255, 255, 0);
    } 
    rect(x, y, boxSize, boxSize);
  }

  void teller() {
    if (locked==true && soundTriggered==false) {
      fileBox.play();
      soundTriggered = true;
    } 
    if (locked==false && soundTriggered==true) {
      soundTriggered = false;
      return;
    }
  }
}