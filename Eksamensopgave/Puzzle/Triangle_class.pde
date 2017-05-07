
class Triangle extends Box { //der laves en class for triangle, der udvider Box-classen. Dette gør, at man kan bruge alle værdier fra box uden, at det ændre noget ved box
  Polygon2D poly=new Polygon2D(); //skrevet af toxmeister (https://forum.processing.org/one/topic/mouse-within-a-certain-area.html)

  Triangle(float setx, float sety) { //contructor for triangle, x og y sættes setup
    x = setx;
    y = sety;
  }

  //nedenstående kode-del er lånt fra et svar af toxmeister på et spørgsmål på processings forum (https://forum.processing.org/one/topic/mouse-within-a-certain-area.html)
  void check() { //check-funktion, der tjekker om musen er over triangle
    //der opbygges en zone over trekanten (nederst), der er givet som punkter i 2D-vektorer
    poly.add(new Vec2D(x, y)); //toxmeister, med tilpasning (det ene hjørne)
    poly.add(new Vec2D(x+80, y-80)); //toxmeister, med tilpasning (det andet hjørne)
    poly.add(new Vec2D(x+160, y)); //toxmeister, med tilpasning (det tredje hjørne)
    // tjekker om musen er indenfor punkterne
    if (poly.containsPoint(new Vec2D(mouseX, mouseY))) { //toxmeister, med tilpasning (containsPoint er en funktion i toxi.geom)
      overBox = true; //er den, så sætter den triangles overBox til true
      if (!locked) { //og hvis locked er falsk så
        stroke(255); //sætter den stroke til hvid og
        fill(153); //triangle er grå
      }
    } else {
      noStroke(); //er det ikke opfyldt, så er der ingen stroke
      overBox = false; //og overbox sættes til falsk
    }
  }

  void display() {
    if (overBox && locked) { //hvis musen er over triangle og triangle er låst/valgt så
      fill(255); //farves triangle hvid
    } else {
      fill(153); //ellers så forbliver triangle grå
    }
    if (triangleHome==true) { //hvis triangle er placeret rigtigt af brugeren, så 
      fill(255, 255, 0); //farves triangle gul
    } 
    triangle(x, y, x+80, y-80, x+160, y); //triangle tegnes. Punkter får den fra checker
  }

  void teller() { //teller-funktion, der fortæller navnet på triangle. Her er det det engelske "triangle"
    if (locked==true && soundTriggered==false) { //er der klikket på triangle og lyden har ikke været før så
      fileTriangle.play(); //afspiller den lydfilen for fileTriangle
      soundTriggered = true; //og sætter at lyden er afspillet til "true"
    } 
    if (locked==false && soundTriggered==true) { //Så tjekker den om triangle er sluppen og om lyden har været afspillet før, for så
      soundTriggered = false; //sætter den soundTriggered tilbage til "false", så lyden er klar til at blive afspillet igen
    }
  }
}