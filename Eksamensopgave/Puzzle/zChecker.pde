
class Checker extends House {
  Polygon2D poly1=new Polygon2D();

  void check() { 
    // add corner points of house

    x = 350;
    y = 400;

    //poly1.add(new Vec2D(x-boxSize, y)); //toxmeister, med tilpasning (venstre nederst)
    //poly1.add(new Vec2D(x-boxSize, y-boxSize*2 )); (venstre øverst)
    //poly1.add(new Vec2D(x, y-boxSize*3)); //toxmeister, med tilpasning (top)
    //poly1.add(new Vec2D(x+boxSize, y-boxSize*2)); (højre øverst)
    //poly1.add(new Vec2D(x+boxSize, y)); //toxmeister, med tilpasning (højre nederst)

    poly1.add(new Vec2D(x-boxSize, y-boxSize*2 ));
    poly1.add(new Vec2D(x, y-boxSize*3)); //toxmeister, med tilpasning
    poly1.add(new Vec2D(x+boxSize, y-boxSize*2));

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