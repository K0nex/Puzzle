
class Checker extends House {
  Polygon2D poly1=new Polygon2D();

  void check() { 
    // add corner points of house

    poly1.add(new Vec2D(x-boxSize, y*2)); //toxmeister, med tilpasning
    poly1.add(new Vec2D(x-boxSize, y*2-boxSize*2 ));
    poly1.add(new Vec2D(x, y*2-boxSize*3)); //toxmeister, med tilpasning
    poly1.add(new Vec2D(x+boxSize, y*2-boxSize*2));
    poly1.add(new Vec2D(x+boxSize, y*2)); //toxmeister, med tilpasning

    // check if mouse pos is inside
    if (poly1.containsPoint(new Vec2D(mouseX, mouseY))) { //toxmeister, med tilpasning
      //println("bingo");
      pushStyle();
      textSize(100);
      fill(0);
      textAlign(CENTER);
      text("Godt klaret", width/2, height/4);
      popStyle();
    }
  }
}