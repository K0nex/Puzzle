PShape house, wall, roof;

void setup() {
  size(300, 300);

  // Create the shape group
  house = createShape(GROUP);

  // Make two shapes
  noFill();
  rectMode(CENTER);
  wall = createShape(RECT, width/2, height/2, 80, 80);
  //wall.setFill(color(255));
  roof = createShape(TRIANGLE, width/2-40, height/2-40, width/2, height/2-80, width/2+40, height/2-40);
  //roof.setFill(color(0));

  // Add the two "child" shapes to the parent group
  house.addChild(wall);
  house.addChild(roof);
}

void draw() {
  background(204);
  //translate(50, 15);
  shape(house); // Draw the group
}