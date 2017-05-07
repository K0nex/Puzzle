/*
Skrevet af Mark L. Petersen, HTX3
 Teknisk Gymnasium Sønderjylland Tønder
 
 Dette er eksamensopgaven i Programmering C på HTX.
 Opgaven er at lave en brugeroplevelse, hvor brugeren kan interaggere med programmet.
 Jeg har lavet et spil, der sætter fokus på geometri og sprog.
 Målgruppen er 
 
 Hjælp er hentet ved bl.a. Kasper Kristensen og processing.org
 
 Programmet har en lille fejl til sidst, men fungerer efter hensigtet, når det startes anden gang.
 */

import toxi.geom.*; //importerer Toxiclibs pakken geom, der bl.a. indeholder 2D- og 3D-vector funtioner
import processing.sound.*; //importerer Processings eget lyd-bibliotek
SoundFile fileBox; //Laver en lydfil for box
SoundFile fileTriangle; //laver en lydfil for triangle

boolean boxHome = false; //boxHome er om box'en er placeret korrekt, dette sættes med en boolean, som starter med at være falsk (ikke placeret korrekt)
boolean triangleHome = false; //det samme gælder for triangles placering

ArrayList<Box> gameObjects; //Laver en arrayliste, som gemmer et variabelt antal objecter. Her er det antal af "box"
Box myBox1; //Box-class'en erklæres som et obejct
Triangle myTriangle1; //Samme som ved Box
House myHouse; //Samme som ved Box

void setup() { //Opsætter basis for programmet
  size(700, 700); //Sætter skærmstørrelsen 

  myHouse = new House(); //House-objectet initialises ved at constructe det som en funktion, der for alle houses variabler med

  gameObjects = new ArrayList<Box>(); //samme princip som ved myHouse

  myBox1 = new Box(200, 200); //samme princip som ved myHouse, dog så sættes x og y for Box, hvilket påvirker box' parameter
  gameObjects.add(myBox1); //myBox1 tilføjes til arraylisten og bliver en del af gameObejcts

  myTriangle1 = new Triangle(400, 200); //samme princip som ved myBox1
  gameObjects.add(myTriangle1); //myTriangle1 tilføjes til arraylisten og bliver en del af gameObejcts

  fileBox= new SoundFile(this, "firkant.mp3"); //importerer filen fra "data". Filen stammer fra ordnet.dk http://static.ordnet.dk/mp3/11013/11013152_1.mp3
  fileTriangle= new SoundFile(this, "trekant.mp3"); //importerer filen fra "data". Filen stammer fra ordnet.dk http://static.ordnet.dk/mp3/12002/12002243_1.mp3
}

void draw() { //dette skal køres i loop   
  background(#00ECFF); //laver en baggrund i en glad tyrkisblå. Denne sættes først, så når tingene flyttes senere, så forsvinder tidligere placeringer

  pushStyle(); //pushStyle gemmer tidligere opsætning, så man kan ændre stilen uden at påvirker resten
  textSize(15); //sætter den kommende tekst til størrelsen 15 pixel
  fill(0); //farven skal være sort
  textAlign(LEFT); //teksten venstrejusteres
  text("Flyt figurne indenfor stregerne", 10, 50); //den skrevende tekst. Først kommer teksten og bagefter placeringen
  text("og dan en ny figur :)", 10, 70); //den skrevende tekst. Først kommer teksten og bagefter placeringen
  popStyle(); //popStyle fortsætter fra hvor pushStyle gemmer

  myHouse.display(); //Kalder display-funktionen for myHouse, så house vises

  myBox1.check(); //Kalder check-funktionen for myBox, så kanten lyser op, når musen er over box
  myBox1.display(); //samme princip som ved myHouse.display
  myBox1.teller(); //Kalder teller-funktionen for myBox, der siger "square" når der trykkes på square

  myTriangle1.check(); //samme princip som ved myBox1.check
  myTriangle1.display(); //samme princip som ved myHouse.display
  myTriangle1.teller(); //samme princip som ved myBox1.teller, dog så siger den "triangle" i stedet

  //Dette er if-statements, der holder øje med om box og triangle er på rette plads
  if (sqrt(pow(abs(myHouse.x - myBox1.x), 2)+pow(abs(myHouse.y-80 - myBox1.y), 2)) < 10) { //dette udnytter afstandsformlen til at finde afstanden fra center af house og box, og når afstanden når under 10, så opfyldes statementet og nedenstående sker
    boxHome = true; //hvis overstående kriterie er opfyldt, så sættes boxHome til "true"
  } else {
    boxHome = false; //hvis den ikke er, så er boxHome "falsk" altså ikke på plads
  }
  if (sqrt(pow(abs(myHouse.x-80 - myTriangle1.x), 2)+pow(abs(myHouse.y-150 - myTriangle1.y), 2)) < 10) { //dette udnytter afstandsformlen til at finde afstanden fra center af house og triangle, og når afstanden når under 10, så opfyldes statementet og nedenstående sker
    triangleHome = true; //hvis overstående kriterie er opfyldt, så sættes triangleHome til "true"
  } else {
    triangleHome = false; //hvis den ikke er, så er triangleHome "falsk" altså ikke på plads
  }


  if (boxHome==true && triangleHome==true) { //når box og triangle er placeret rigtigt, så kan nedenstående forløbe. Dette sker når spillets opgave er løst
    pushStyle(); //gemmer tidligere stil
    textSize(100); //sætter tekststørrelsen til 100 pixel
    fill(0); //farven er sort
    textAlign(CENTER); //teksten justeres til center
    text("Godt klaret", width/2, height/4); //tekst der fortæller af opgaven er udført + placeringen af teksten
    textSize(20); //sætter en ny tekststørrelse 
    text("Spillet lukkes om lidt", width/2, height/3); //ny tekst, der fortæller at spillet lukker om et øjeblik
    popStyle(); //fortsætter hvor pushStyle gemte
    noCursor(); //skjuler musen for at stoppe brugeren med at interaggere
    if (frameCount > 650) { //hvis overstående if-statement er opfyldt, så starter en frameCounter og når den når over 650 frames, så starter nedenstående
      exit(); //efter at spillets opgave er klaret, så går der 650 frames og spillet lukker
    }
  }
}

//nedenstående kode er lånt fra https://processing.org/examples/mousefunctions.html og tilpasset
void mousePressed() { //kalder processings mousePressed-funktion, der aktiveres når musen klikker
  //for-loopen er lånt fra vores Shoot Em Up-projekt
  for (int i = 0; i < gameObjects.size(); i++) { //for-loopen kontrollerer en række af gentagelser. Først sættes i til nul, hvor arrayet starter. Så skal i være mindre end størrelsen på gameObejcts. Hvis det er "true" så stiger i med 1.
    Box obj = gameObjects.get(i); //Box-objectet bliver et nummer i arrayen
    obj.xOffset = mouseX-obj.x; // sætter den variable xOffset fra box-class'en til musens placering minus det valgte objects x-værdi. Dette sikrer, at objectet ikke sprænger hen til musens placering.
    obj.yOffset = mouseY-obj.y; // sætter den variable yOffset fra box-class'en til musens placering minus det valgte objects y-værdi. Dette sikrer, at objectet ikke sprænger hen til musens placering.
    if (obj.overBox) { //samtidigt så holder den øje med om musen er over objectet 
      obj.locked = true; //er den, og der klikkes på objectet, så melder den objectet som låst værende for "true"
    } else {
      obj.locked = false; //hvis der ikke klikkes, så sætter den objectets locked til "false"
    }
  }
}

//nedenstående kode er lånt fra https://processing.org/examples/mousefunctions.html og tilpasset
void mouseDragged() { //kalder processings mouseDragged-funktion, der aktiveres når musen flyttes
  for (int i = 0; i < gameObjects.size(); i++) { //for-loopen kontrollerer en række af gentagelser. Først sættes i til nul, hvor arrayet starter. Så skal i være mindre end størrelsen på gameObejcts. Hvis det er "true" så stiger i med 1.
    Box obj = gameObjects.get(i);  //Box-objectet bliver et nummer i arrayen
    if (obj.locked) { //er objectet låst så
      obj.x = mouseX-obj.xOffset; //sætter den obejctets x til musens placering minus offsettet
      obj.y = mouseY-obj.yOffset; //sætter den obejctets y til musens placering minus offsettet
    }
  }
}

//nedenstående kode er lånt fra https://processing.org/examples/mousefunctions.html og tilpasset
void mouseReleased() { //kalder processings mouseReleased-funktion, der aktiveres når musen slippes
  for (int i = 0; i < gameObjects.size(); i++) { //for-loopen kontrollerer en række af gentagelser. Først sættes i til nul, hvor arrayet starter. Så skal i være mindre end størrelsen på gameObejcts. Hvis det er "true" så stiger i med 1.
    Box obj = gameObjects.get(i); //Box-objectet bliver et nummer i arrayen
    obj.locked = false; //slipper man musen, så er obejctet ikke valg og locked bliver "false"
  }
}