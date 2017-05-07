
class Box { //Der laves en class for Box
  //Data-delen, visse er fra https://processing.org/examples/mousefunctions.html
  float x; //x som variable
  float y; //y som variable
  int boxSize = 80; //laver kassestørrelsen til en fast værdi
  boolean overBox = false; //true/false om der er noget over box, falsk til at starte med
  boolean locked = false; //true/false om box er låst, falsk til at starte med
  boolean presBox = false; //true/false om box er presset, falsk til at starte med
  boolean soundTriggered = false; //true/false om lyden er afspillet, falsk til at starte med
  float xOffset = 0.0; //den variable x-offset
  float yOffset = 0.0; //den variable y-offset

  Box() { //En constructor for box, sætter nogle basis ting for box. Her er det placering
    x = width/2.0; //x-værdi
    y = height/2.0-100; //y-værdi
  }

  Box(float setx, float sety) { //Ny constructor, hvor x og y kan ændres, når box initialises
    x = setx;
    y = sety;
  }

  //Nedenstående kode-del er lånt fra https://processing.org/tutorials/interactivity/ og tilpasset
  void check() { //Checker-funktion, der tjekker om musen er over box
    //Test if the cursor is over the box (opsætter en zone over box)
    if (mouseX > x-boxSize && mouseX < x+boxSize && //indenfor box'ens bredde
      mouseY > y-boxSize && mouseY < y+boxSize) { //indenfor box'ens højde
      overBox = true; //hvis musen er over kassen, så er overBox true
      if (!locked) { //og hvis locked er falsk så
        stroke(255); //sætter den stroke til hvid og
        fill(153); //box er grå
      }
    } else {
      noStroke(); //er det ikke opfyldt, så er der ingen stroke
      overBox = false; //og overbox sættes til falsk
    }
  }

  void display() { //display-funktionen, denne viser box'en
    rectMode(RADIUS); //laver justeringen af firkanten til center, så placering og størrelse regnes fra firkantens midte
    if (overBox && locked) { //hvis musen er over box'en og box er låst/valgt så
      fill(255); //farves box hvid
    } else {
      fill(153); //ellers så forbliver box grå
    }
    if (boxHome==true) { //hvis box'en er placeret rigtigt af brugeren, så 
      fill(255, 255, 0); //farves box'en gul
    } 
    rect(x, y, boxSize, boxSize); //tegner box'en. Placeringen sættes fra værdierne i contructoren
  }

  void teller() { //teller-funktion, der fortæller navnet på box'en. Her er det "firkant"
    if (locked==true && soundTriggered==false) { //er der klikket på box'en og lyden har ikke været før så
      fileBox.play(); //afspiller den lydfilen for fileBox
      soundTriggered = true; //og sætter at lyden er afspillet til "true"
    } 
    if (locked==false && soundTriggered==true) { //Så tjekker den om box'en er sluppen og om lyden har været afspillet før, for så
      soundTriggered = false; //sætter den soundTriggered tilbage til "false", så lyden er klar til at blive afspillet igen
    }
  }
}