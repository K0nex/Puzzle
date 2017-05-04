
class Checker extends Box {
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
      println("bingo");
      //overBox = true;
    }
  }
}

//wall1 = createShape(LINE, x-boxSize, y*2, x-boxSize, y*2-boxSize*2);
//wall2 = createShape(LINE, x+boxSize, y*2-boxSize*2, x+boxSize, y*2);
////wall.setFill(color(255));
////roof1 = createShape(TRIANGLE, x-boxSize, y*2-boxSize*2, x, y*2-boxSize*3, x+boxSize, y*2-boxSize*2);
////roof.setFill(color(0));
//roof1 = createShape(LINE, x-boxSize, y*2-boxSize*2, x, y*2-boxSize*3);
//roof2 = createShape(LINE, x, y*2-boxSize*3, x+boxSize, y*2-boxSize*2);
//floor = createShape(LINE, x+boxSize, y*2, x-boxSize, y*2);