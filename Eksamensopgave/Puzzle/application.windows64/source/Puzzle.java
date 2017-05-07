import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import toxi.geom.*; 
import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Puzzle extends PApplet {

/*
Skrevet af Mark L. Petersen, HTX3
 Teknisk Gymnasium S\u00f8nderjylland T\u00f8nder
 
 Dette er eksamensopgaven i Programmering C p\u00e5 HTX.
 Opgaven er at lave en brugeroplevelse, hvor brugeren kan interaggere med programmet.
 Jeg har lavet et spil, der s\u00e6tter fokus p\u00e5 geometri og sprog.
 M\u00e5lgruppen er 
 
 Hj\u00e6lp er hentet ved bl.a. Kasper Kristensen og processing.org
 
 Programmet har en lille fejl til sidst, men fungerer efter hensigtet, n\u00e5r det startes anden gang.
 */

 //importerer Toxiclibs pakken geom, der bl.a. indeholder 2D- og 3D-vector funtioner
 //importerer Processings eget lyd-bibliotek
SoundFile fileBox; //Laver en lydfil for box
SoundFile fileTriangle; //laver en lydfil for triangle

boolean boxHome = false; //boxHome er om box'en er placeret korrekt, dette s\u00e6ttes med en boolean, som starter med at v\u00e6re falsk (ikke placeret korrekt)
boolean triangleHome = false; //det samme g\u00e6lder for triangles placering

ArrayList<Box> gameObjects; //Laver en arrayliste, som gemmer et variabelt antal objecter. Her er det antal af "box"
Box myBox1; //Box-class'en erkl\u00e6res som et obejct
Triangle myTriangle1; //Samme som ved Box
House myHouse; //Samme som ved Box

public void setup() { //Ops\u00e6tter basis for programmet
   //S\u00e6tter sk\u00e6rmst\u00f8rrelsen 

  myHouse = new House(); //House-objectet initialises ved at constructe det som en funktion, der for alle houses variabler med

  gameObjects = new ArrayList<Box>(); //samme princip som ved myHouse

  myBox1 = new Box(200, 200); //samme princip som ved myHouse, dog s\u00e5 s\u00e6ttes x og y for Box, hvilket p\u00e5virker box' parameter
  gameObjects.add(myBox1); //myBox1 tilf\u00f8jes til arraylisten og bliver en del af gameObejcts

  myTriangle1 = new Triangle(400, 200); //samme princip som ved myBox1
  gameObjects.add(myTriangle1); //myTriangle1 tilf\u00f8jes til arraylisten og bliver en del af gameObejcts

  fileBox= new SoundFile(this, "firkant.mp3"); //importerer filen fra "data". Filen stammer fra ordnet.dk http://static.ordnet.dk/mp3/11013/11013152_1.mp3
  fileTriangle= new SoundFile(this, "trekant.mp3"); //importerer filen fra "data". Filen stammer fra ordnet.dk http://static.ordnet.dk/mp3/12002/12002243_1.mp3
}

public void draw() { //dette skal k\u00f8res i loop   
  background(0xff00ECFF); //laver en baggrund i en glad tyrkisbl\u00e5. Denne s\u00e6ttes f\u00f8rst, s\u00e5 n\u00e5r tingene flyttes senere, s\u00e5 forsvinder tidligere placeringer

  pushStyle(); //pushStyle gemmer tidligere ops\u00e6tning, s\u00e5 man kan \u00e6ndre stilen uden at p\u00e5virker resten
  textSize(15); //s\u00e6tter den kommende tekst til st\u00f8rrelsen 15 pixel
  fill(0); //farven skal v\u00e6re sort
  textAlign(LEFT); //teksten venstrejusteres
  text("Flyt figurne indenfor stregerne", 10, 50); //den skrevende tekst. F\u00f8rst kommer teksten og bagefter placeringen
  text("og dan en ny figur :)", 10, 70); //den skrevende tekst. F\u00f8rst kommer teksten og bagefter placeringen
  popStyle(); //popStyle forts\u00e6tter fra hvor pushStyle gemmer

  myHouse.display(); //Kalder display-funktionen for myHouse, s\u00e5 house vises

  myBox1.check(); //Kalder check-funktionen for myBox, s\u00e5 kanten lyser op, n\u00e5r musen er over box
  myBox1.display(); //samme princip som ved myHouse.display
  myBox1.teller(); //Kalder teller-funktionen for myBox, der siger "square" n\u00e5r der trykkes p\u00e5 square

  myTriangle1.check(); //samme princip som ved myBox1.check
  myTriangle1.display(); //samme princip som ved myHouse.display
  myTriangle1.teller(); //samme princip som ved myBox1.teller, dog s\u00e5 siger den "triangle" i stedet

  //Dette er if-statements, der holder \u00f8je med om box og triangle er p\u00e5 rette plads
  if (sqrt(pow(abs(myHouse.x - myBox1.x), 2)+pow(abs(myHouse.y-80 - myBox1.y), 2)) < 10) { //dette udnytter afstandsformlen til at finde afstanden fra center af house og box, og n\u00e5r afstanden n\u00e5r under 10, s\u00e5 opfyldes statementet og nedenst\u00e5ende sker
    boxHome = true; //hvis overst\u00e5ende kriterie er opfyldt, s\u00e5 s\u00e6ttes boxHome til "true"
  } else {
    boxHome = false; //hvis den ikke er, s\u00e5 er boxHome "falsk" alts\u00e5 ikke p\u00e5 plads
  }
  if (sqrt(pow(abs(myHouse.x-80 - myTriangle1.x), 2)+pow(abs(myHouse.y-150 - myTriangle1.y), 2)) < 10) { //dette udnytter afstandsformlen til at finde afstanden fra center af house og triangle, og n\u00e5r afstanden n\u00e5r under 10, s\u00e5 opfyldes statementet og nedenst\u00e5ende sker
    triangleHome = true; //hvis overst\u00e5ende kriterie er opfyldt, s\u00e5 s\u00e6ttes triangleHome til "true"
  } else {
    triangleHome = false; //hvis den ikke er, s\u00e5 er triangleHome "falsk" alts\u00e5 ikke p\u00e5 plads
  }


  if (boxHome==true && triangleHome==true) { //n\u00e5r box og triangle er placeret rigtigt, s\u00e5 kan nedenst\u00e5ende forl\u00f8be. Dette sker n\u00e5r spillets opgave er l\u00f8st
    pushStyle(); //gemmer tidligere stil
    textSize(100); //s\u00e6tter tekstst\u00f8rrelsen til 100 pixel
    fill(0); //farven er sort
    textAlign(CENTER); //teksten justeres til center
    text("Godt klaret", width/2, height/4); //tekst der fort\u00e6ller af opgaven er udf\u00f8rt + placeringen af teksten
    textSize(20); //s\u00e6tter en ny tekstst\u00f8rrelse 
    text("Spillet lukkes om lidt", width/2, height/3); //ny tekst, der fort\u00e6ller at spillet lukker om et \u00f8jeblik
    popStyle(); //forts\u00e6tter hvor pushStyle gemte
    noCursor(); //skjuler musen for at stoppe brugeren med at interaggere
    if (frameCount > 650) { //hvis overst\u00e5ende if-statement er opfyldt, s\u00e5 starter en frameCounter og n\u00e5r den n\u00e5r over 650 frames, s\u00e5 starter nedenst\u00e5ende
      exit(); //efter at spillets opgave er klaret, s\u00e5 g\u00e5r der 650 frames og spillet lukker
    }
  }
}

//nedenst\u00e5ende kode er l\u00e5nt fra https://processing.org/examples/mousefunctions.html og tilpasset
public void mousePressed() { //kalder processings mousePressed-funktion, der aktiveres n\u00e5r musen klikker
  //for-loopen er l\u00e5nt fra vores Shoot Em Up-projekt
  for (int i = 0; i < gameObjects.size(); i++) { //for-loopen kontrollerer en r\u00e6kke af gentagelser. F\u00f8rst s\u00e6ttes i til nul, hvor arrayet starter. S\u00e5 skal i v\u00e6re mindre end st\u00f8rrelsen p\u00e5 gameObejcts. Hvis det er "true" s\u00e5 stiger i med 1.
    Box obj = gameObjects.get(i); //Box-objectet bliver et nummer i arrayen
    obj.xOffset = mouseX-obj.x; // s\u00e6tter den variable xOffset fra box-class'en til musens placering minus det valgte objects x-v\u00e6rdi. Dette sikrer, at objectet ikke spr\u00e6nger hen til musens placering.
    obj.yOffset = mouseY-obj.y; // s\u00e6tter den variable yOffset fra box-class'en til musens placering minus det valgte objects y-v\u00e6rdi. Dette sikrer, at objectet ikke spr\u00e6nger hen til musens placering.
    if (obj.overBox) { //samtidigt s\u00e5 holder den \u00f8je med om musen er over objectet 
      obj.locked = true; //er den, og der klikkes p\u00e5 objectet, s\u00e5 melder den objectet som l\u00e5st v\u00e6rende for "true"
    } else {
      obj.locked = false; //hvis der ikke klikkes, s\u00e5 s\u00e6tter den objectets locked til "false"
    }
  }
}

//nedenst\u00e5ende kode er l\u00e5nt fra https://processing.org/examples/mousefunctions.html og tilpasset
public void mouseDragged() { //kalder processings mouseDragged-funktion, der aktiveres n\u00e5r musen flyttes
  for (int i = 0; i < gameObjects.size(); i++) { //for-loopen kontrollerer en r\u00e6kke af gentagelser. F\u00f8rst s\u00e6ttes i til nul, hvor arrayet starter. S\u00e5 skal i v\u00e6re mindre end st\u00f8rrelsen p\u00e5 gameObejcts. Hvis det er "true" s\u00e5 stiger i med 1.
    Box obj = gameObjects.get(i);  //Box-objectet bliver et nummer i arrayen
    if (obj.locked) { //er objectet l\u00e5st s\u00e5
      obj.x = mouseX-obj.xOffset; //s\u00e6tter den obejctets x til musens placering minus offsettet
      obj.y = mouseY-obj.yOffset; //s\u00e6tter den obejctets y til musens placering minus offsettet
    }
  }
}

//nedenst\u00e5ende kode er l\u00e5nt fra https://processing.org/examples/mousefunctions.html og tilpasset
public void mouseReleased() { //kalder processings mouseReleased-funktion, der aktiveres n\u00e5r musen slippes
  for (int i = 0; i < gameObjects.size(); i++) { //for-loopen kontrollerer en r\u00e6kke af gentagelser. F\u00f8rst s\u00e6ttes i til nul, hvor arrayet starter. S\u00e5 skal i v\u00e6re mindre end st\u00f8rrelsen p\u00e5 gameObejcts. Hvis det er "true" s\u00e5 stiger i med 1.
    Box obj = gameObjects.get(i); //Box-objectet bliver et nummer i arrayen
    obj.locked = false; //slipper man musen, s\u00e5 er obejctet ikke valg og locked bliver "false"
  }
}

class Box { //Der laves en class for Box
  //Data-delen, visse er fra https://processing.org/examples/mousefunctions.html
  float x; //x som variable
  float y; //y som variable
  int boxSize = 80; //laver kassest\u00f8rrelsen til en fast v\u00e6rdi
  boolean overBox = false; //true/false om der er noget over box, falsk til at starte med
  boolean locked = false; //true/false om box er l\u00e5st, falsk til at starte med
  boolean presBox = false; //true/false om box er presset, falsk til at starte med
  boolean soundTriggered = false; //true/false om lyden er afspillet, falsk til at starte med
  float xOffset = 0.0f; //den variable x-offset
  float yOffset = 0.0f; //den variable y-offset

  Box() { //En constructor for box, s\u00e6tter nogle basis ting for box. Her er det placering
    x = width/2.0f; //x-v\u00e6rdi
    y = height/2.0f-100; //y-v\u00e6rdi
  }

  Box(float setx, float sety) { //Ny constructor, hvor x og y kan \u00e6ndres, n\u00e5r box initialises
    x = setx;
    y = sety;
  }

  //Nedenst\u00e5ende kode-del er l\u00e5nt fra https://processing.org/tutorials/interactivity/ og tilpasset
  public void check() { //Checker-funktion, der tjekker om musen er over box
    //Test if the cursor is over the box (ops\u00e6tter en zone over box)
    if (mouseX > x-boxSize && mouseX < x+boxSize && //indenfor box'ens bredde
      mouseY > y-boxSize && mouseY < y+boxSize) { //indenfor box'ens h\u00f8jde
      overBox = true; //hvis musen er over kassen, s\u00e5 er overBox true
      if (!locked) { //og hvis locked er falsk s\u00e5
        stroke(255); //s\u00e6tter den stroke til hvid og
        fill(153); //box er gr\u00e5
      }
    } else {
      noStroke(); //er det ikke opfyldt, s\u00e5 er der ingen stroke
      overBox = false; //og overbox s\u00e6ttes til falsk
    }
  }

  public void display() { //display-funktionen, denne viser box'en
    rectMode(RADIUS); //laver justeringen af firkanten til center, s\u00e5 placering og st\u00f8rrelse regnes fra firkantens midte
    if (overBox && locked) { //hvis musen er over box'en og box er l\u00e5st/valgt s\u00e5
      fill(255); //farves box hvid
    } else {
      fill(153); //ellers s\u00e5 forbliver box gr\u00e5
    }
    if (boxHome==true) { //hvis box'en er placeret rigtigt af brugeren, s\u00e5 
      fill(255, 255, 0); //farves box'en gul
    } 
    rect(x, y, boxSize, boxSize); //tegner box'en. Placeringen s\u00e6ttes fra v\u00e6rdierne i contructoren
  }

  public void teller() { //teller-funktion, der fort\u00e6ller navnet p\u00e5 box'en. Her er det "firkant"
    if (locked==true && soundTriggered==false) { //er der klikket p\u00e5 box'en og lyden har ikke v\u00e6ret f\u00f8r s\u00e5
      fileBox.play(); //afspiller den lydfilen for fileBox
      soundTriggered = true; //og s\u00e6tter at lyden er afspillet til "true"
    } 
    if (locked==false && soundTriggered==true) { //S\u00e5 tjekker den om box'en er sluppen og om lyden har v\u00e6ret afspillet f\u00f8r, for s\u00e5
      soundTriggered = false; //s\u00e6tter den soundTriggered tilbage til "false", s\u00e5 lyden er klar til at blive afspillet igen
    }
  }
}

class House extends Box { //der laves en class for house, der udvider Box-classen. Dette g\u00f8r, at man kan bruge alle v\u00e6rdier fra box uden, at det \u00e6ndre noget ved box
  
  // nedenst\u00e5ende kode er l\u00e5nt og tilpasset fra https://processing.org/reference/createShape_.html
  PShape house, floor, wall1, wall2, roof1, roof2; //s\u00e6tter objecterne for PShape
  {    
    x = 350;
    y = 500;
    house = createShape(GROUP); //laver gruppen af former, hvor house bliver moder-formen

    //Make shapes (laver formerne som b\u00f8rn af moder-formen)
    //de er alle lavet som lines for at skabe et omrids af et hus
    //koordinaterne er lavet ud fra hj\u00f8rnerne for box og triangle
    wall1 = createShape(LINE, x-boxSize, y, x-boxSize, y-boxSize*2);
    wall2 = createShape(LINE, x+boxSize, y-boxSize*2, x+boxSize, y);
    roof1 = createShape(LINE, x-boxSize, y-boxSize*2, x, y-boxSize*3);
    roof2 = createShape(LINE, x, y-boxSize*3, x+boxSize, y-boxSize*2);
    floor = createShape(LINE, x+boxSize, y, x-boxSize, y);

    //"B\u00f8rne-formerne" tilf\u00f8jes moderen
    house.addChild(wall1);
    house.addChild(wall2);
    house.addChild(roof1);
    house.addChild(roof2);
    house.addChild(floor);
  }

  public void display() {
    shape(house); // tegner moder-formen
  }
}

class Triangle extends Box { //der laves en class for triangle, der udvider Box-classen. Dette g\u00f8r, at man kan bruge alle v\u00e6rdier fra box uden, at det \u00e6ndre noget ved box
  Polygon2D poly=new Polygon2D(); //skrevet af toxmeister (https://forum.processing.org/one/topic/mouse-within-a-certain-area.html)

  Triangle(float setx, float sety) { //contructor for triangle, x og y s\u00e6ttes setup
    x = setx;
    y = sety;
  }

  //nedenst\u00e5ende kode-del er l\u00e5nt fra et svar af toxmeister p\u00e5 et sp\u00f8rgsm\u00e5l p\u00e5 processings forum (https://forum.processing.org/one/topic/mouse-within-a-certain-area.html)
  public void check() { //check-funktion, der tjekker om musen er over triangle
    //der opbygges en zone over trekanten (nederst), der er givet som punkter i 2D-vektorer
    poly.add(new Vec2D(x, y)); //toxmeister, med tilpasning (det ene hj\u00f8rne)
    poly.add(new Vec2D(x+80, y-80)); //toxmeister, med tilpasning (det andet hj\u00f8rne)
    poly.add(new Vec2D(x+160, y)); //toxmeister, med tilpasning (det tredje hj\u00f8rne)
    // tjekker om musen er indenfor punkterne
    if (poly.containsPoint(new Vec2D(mouseX, mouseY))) { //toxmeister, med tilpasning (containsPoint er en funktion i toxi.geom)
      overBox = true; //er den, s\u00e5 s\u00e6tter den triangles overBox til true
      if (!locked) { //og hvis locked er falsk s\u00e5
        stroke(255); //s\u00e6tter den stroke til hvid og
        fill(153); //triangle er gr\u00e5
      }
    } else {
      noStroke(); //er det ikke opfyldt, s\u00e5 er der ingen stroke
      overBox = false; //og overbox s\u00e6ttes til falsk
    }
  }

  public void display() {
    if (overBox && locked) { //hvis musen er over triangle og triangle er l\u00e5st/valgt s\u00e5
      fill(255); //farves triangle hvid
    } else {
      fill(153); //ellers s\u00e5 forbliver triangle gr\u00e5
    }
    if (triangleHome==true) { //hvis triangle er placeret rigtigt af brugeren, s\u00e5 
      fill(255, 255, 0); //farves triangle gul
    } 
    triangle(x, y, x+80, y-80, x+160, y); //triangle tegnes. Punkter f\u00e5r den fra checker
  }

  public void teller() { //teller-funktion, der fort\u00e6ller navnet p\u00e5 triangle. Her er det "trekant"
    if (locked==true && soundTriggered==false) { //er der klikket p\u00e5 triangle og lyden har ikke v\u00e6ret f\u00f8r s\u00e5
      fileTriangle.play(); //afspiller den lydfilen for fileTriangle
      soundTriggered = true; //og s\u00e6tter at lyden er afspillet til "true"
    } 
    if (locked==false && soundTriggered==true) { //S\u00e5 tjekker den om triangle er sluppen og om lyden har v\u00e6ret afspillet f\u00f8r, for s\u00e5
      soundTriggered = false; //s\u00e6tter den soundTriggered tilbage til "false", s\u00e5 lyden er klar til at blive afspillet igen
    }
  }
}
  public void settings() {  size(700, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#0099FF", "--stop-color=#cccccc", "Puzzle" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
