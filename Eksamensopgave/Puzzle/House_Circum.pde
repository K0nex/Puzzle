
class House extends Box {

  PShape house, floor, wall1, wall2, roof1, roof2; // lånt og tilpasset fra https://processing.org/reference/createShape_.html
  {
    // Create the shape group
    house = createShape(GROUP);

    // Make shapes
    noFill();
    //rectMode(CENTER);
    //wall = createShape(RECT, x, y*2-boxSize, boxSize*2, boxSize*2);
    wall1 = createShape(LINE, x-boxSize, y*2, x-boxSize, y*2-boxSize*2);
    wall2 = createShape(LINE, x+boxSize, y*2-boxSize*2, x+boxSize, y*2);
    //wall.setFill(color(255));
    //roof1 = createShape(TRIANGLE, x-boxSize, y*2-boxSize*2, x, y*2-boxSize*3, x+boxSize, y*2-boxSize*2);
    //roof.setFill(color(0));
    roof1 = createShape(LINE, x-boxSize, y*2-boxSize*2, x, y*2-boxSize*3);
    roof2 = createShape(LINE, x, y*2-boxSize*3, x+boxSize, y*2-boxSize*2);
    floor = createShape(LINE, x+boxSize, y*2, x-boxSize, y*2);

    // Add the two "child" shapes to the parent group
    //house.addChild(wall);
    house.addChild(wall1);
    house.addChild(wall2);
    house.addChild(roof1);
    house.addChild(roof2);
    house.addChild(floor);
  }

  void display() {
    pushStyle();
    translate(0, -100);
    shape(house); // Draw the group
    popStyle();
  }
}