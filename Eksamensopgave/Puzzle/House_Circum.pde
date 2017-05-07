
class House extends Box { //der laves en class for house, der udvider Box-classen. Dette gør, at man kan bruge alle værdier fra box uden, at det ændre noget ved box
  
  // nedenstående kode er lånt og tilpasset fra https://processing.org/reference/createShape_.html
  PShape house, floor, wall1, wall2, roof1, roof2; //sætter objecterne for PShape
  {    
    x = 350;
    y = 500;
    house = createShape(GROUP); //laver gruppen af former, hvor house bliver moder-formen

    //Make shapes (laver formerne som børn af moder-formen)
    //de er alle lavet som lines for at skabe et omrids af et hus
    //koordinaterne er lavet ud fra hjørnerne for box og triangle
    wall1 = createShape(LINE, x-boxSize, y, x-boxSize, y-boxSize*2);
    wall2 = createShape(LINE, x+boxSize, y-boxSize*2, x+boxSize, y);
    roof1 = createShape(LINE, x-boxSize, y-boxSize*2, x, y-boxSize*3);
    roof2 = createShape(LINE, x, y-boxSize*3, x+boxSize, y-boxSize*2);
    floor = createShape(LINE, x+boxSize, y, x-boxSize, y);

    //"Børne-formerne" tilføjes moderen
    house.addChild(wall1);
    house.addChild(wall2);
    house.addChild(roof1);
    house.addChild(roof2);
    house.addChild(floor);
  }

  void display() {
    shape(house); // tegner moder-formen
  }
}