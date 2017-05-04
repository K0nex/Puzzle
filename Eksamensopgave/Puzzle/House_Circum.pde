
class House extends Box {

  PShape house, floor, wall1, wall2, roof1, roof2; // lånt og tilpasset fra https://processing.org/reference/createShape_.html
  {
    x = 350;
    y = 400;
    // Create the shape group
    house = createShape(GROUP);

    // Make shapes
    noFill();
    //wall1 = createShape(LINE, x-boxSize, y*2, x-boxSize, y*2-boxSize*2);
    //wall2 = createShape(LINE, x+boxSize, y*2-boxSize*2, x+boxSize, y*2);
    //roof1 = createShape(LINE, x-boxSize, y*2-boxSize*2, x, y*2-boxSize*3);
    //roof2 = createShape(LINE, x, y*2-boxSize*3, x+boxSize, y*2-boxSize*2);
    //floor = createShape(LINE, x+boxSize, y*2, x-boxSize, y*2);
    
    
     wall1 = createShape(LINE, x-boxSize, y, x-boxSize, y-boxSize*2);
    wall2 = createShape(LINE, x+boxSize, y-boxSize*2, x+boxSize, y);
    roof1 = createShape(LINE, x-boxSize, y-boxSize*2, x, y-boxSize*3);
    roof2 = createShape(LINE, x, y-boxSize*3, x+boxSize, y-boxSize*2);
    floor = createShape(LINE, x+boxSize, y, x-boxSize, y);

    

    // Add the two "child" shapes to the parent group
    house.addChild(wall1);
    house.addChild(wall2);
    house.addChild(roof1);
    house.addChild(roof2);
    house.addChild(floor);
  }

  void display() {
    shape(house); // Draw the group
  }
}