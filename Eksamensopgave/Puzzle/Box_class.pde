class Box {
  float x;
  float y;
  int boxSize = 80;
  boolean overBox = false;
  boolean locked = false;
  float xOffset = 0.0; 
  float yOffset = 0.0;

  Box() {
    x = width/2.0;
    y = height/2.0;
  }

  Box(float setx, float sety) {
    x = setx;
    y = sety;
  }

  void check() { 
    // Test if the cursor is over the box 
    if (mouseX > x-boxSize && mouseX < x+boxSize && 
      mouseY > y-boxSize && mouseY < y+boxSize) {
      overBox = true;  
      if (!locked) { 
        stroke(255); 
        fill(153);
      }
    } else {
      noStroke();
      //fill(153);
      overBox = false;
    }
  }

  void display() {
    rectMode(RADIUS);
    rect(x, y, boxSize, boxSize);
  }
}