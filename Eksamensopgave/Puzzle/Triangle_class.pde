
class Triangle extends Box {
  Polygon2D poly=new Polygon2D(); //skrevet af toxmeister (https://forum.processing.org/one/topic/mouse-within-a-certain-area.html)

  Triangle(float setx, float sety) {
    x = setx;
    y = sety;
  }

  void check() { 
    // add corner points of quad
    poly.add(new Vec2D(x, y)); //toxmeister, med tilpasning
    poly.add(new Vec2D(x+80, y-80)); //toxmeister, med tilpasning
    poly.add(new Vec2D(x+160, y)); //toxmeister, med tilpasning
    // check if mouse pos is inside
    if (poly.containsPoint(new Vec2D(mouseX, mouseY))) { //toxmeister, med tilpasning
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
    if (overBox && locked) {
      fill(255);
    } else {
      fill(153);
    }
    if (triangleHome==true) {
      fill(255, 255, 0);
    } 
    triangle(x, y, x+80, y-80, x+160, y);
  }

  void teller() {
    if (locked==true && soundTriggered==false) {
      fileTriangle.play();
      soundTriggered = true;
    } 
    if (locked==false && soundTriggered==true) {
      soundTriggered = false;
      return;
    }
  }
}