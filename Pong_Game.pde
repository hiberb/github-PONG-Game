int x,y,w,h,speedX,speedY ,paddleXL,paddleYL,paddleW,paddleH,paddleS,paddleXR,paddleYR;     //Mehrere Variablen in einer Deklaration
boolean upL,downL;
boolean upR,downR;
public Boolean Start = true;
public String winscoreausgabe;
public String ausgabe;
public String ausgabe2;


color colorL = color(0,255,0);           // Farbe für Schläger 1 vordefinieren
color colorR = color(255,255,0);        // Farbe für Schläger 2 vordefinieren
color colorQ = color(255,0,0);         //Farbe für Game Over (Rot)
color colorW = color(205,102,29);     //Farbe für die Ausgabe der Scores

int scoreL = 0; //Scores sind vordefiniert mit 0
int scoreR = 0; //Scores sind vordefiniert mit 0

int winscore = 3; //Das ist der Gewinnerscore


void setup()
{
    size(500,500);

  
    x = width /2;
    y = height /2;
    w = 50;
    h = 50;
    speedX = 2;
    speedY = 3;
  
  
    textSize(20);           // Zum Einstellen der Textgröße  
    rectMode(CENTER);      // Text wird zentriert ausgegeben
    paddleXL = 40;
    paddleYL = height /2;
    
    paddleXR = width -49;
    paddleYR = height /2;
  
    paddleW = 30;
    paddleH = 100;
    paddleS = 5;     
}  




void draw()
{
  
  if (Start == true) // Startscreen
  {   
      fill(255,255,255);
           
      background(0);
      text("Spielsteuerung ''Pong Game''",100,30);
      text("------------------------",100,40);
      text("Der linke Spieler verwendet die Tasten 'w' und 's'",1,100);
      text("Der rechte Spieler verwendet die Tasten 'Hoch' und",1,180);
      text("'Runter'",1,230);
      text("Menü aufrufen mit Pfeil nach rechts ->",1,300);
      text("-----------------------------------------------",1,350);
      text("Zum Starten Pfeil nach oben drücken!",1,440);
           
      speedX = 0; // Schnelligkeit X       
      speedY = 0; // Schnelligkeit Y
      
      
      if (keyCode == UP)
      {
         Start = false;
         setup();
         draw();
      }
      
      if (keyCode == RIGHT)
      {
         Start = true;
      }    
  }
  
  else
  
  background(0);
  
  if (Start == false)  // Für den Querstrich in der Mitte = Abtrennung des Spielfeldes
{
  for (int i = 0; i < 800;i++)
  {
      fill(255);
      text("|",245,i);
  }
}
  
  drawCircle();                // Funktionsaufruf zum Darstellen des Circles
  
  moveCircle();               //Funktionsaufruf zum Bewegen des Circles 
 
  bounceoff();               //Funktionsaufruf damit der Ball nicht das Spielfeld verlässt
   
  drawpaddles();           //Funktionsaufruf um den Schläger darzustellen(linker)
  
  movepaddle();          //Funktionsaufruf um den Schläger zu bewegen (linker)
  
  restrictpaddle();     //Funktionsaufruf damit der Schläger nicht das Spielfeld verlässt
  
  contactpaddle();    //Funktionsaufruf damit der Schläger den Ball trifft
  
  scores();         //Ruft die Scorefunktion auf
  
  gameOver();      //Ruft die Game Over Funktion auf;
  
  ausgabe();     //Funktionsaufruf um die aktuelle Scoreanzahl anzuzeigen
   
}

void drawpaddles()
{
  if (Start == true)  
  {
    
    fill(0);
    return;
    
  }
  
  else
  
  fill(colorL); // Farbe
  rect(paddleXL,paddleYL,paddleW,paddleH); //Zeichnen des rechten Schlägers auf dem Bildschirm
  fill(colorR); // Farbe
  rect (paddleXR,paddleYR,paddleW,paddleH); //Zeichnen des linken Schlägers auf dem Bildschirm
}


void movepaddle()
{
    if (upL)
    {  
       paddleYL = paddleYL - paddleS;                  //Um den linken Schläger nach oben zu bewegen
    }    
    if (downL)                          
    {
       paddleYL = paddleYL + paddleS;                  //Um den linken Schläger nach unten zu bewegen
    }    
    if (upR)
    {
       paddleYR = paddleYR - paddleS;                  //Um den rechten Schläger nach oben zu bewegen
    }
    if (downR)
    {
       paddleYR = paddleYR + paddleS;                  //Um den rechten Schläger nach unten zu bewegen
    }
}


void contactpaddle() // Treffen des Balles mit dem Schläger
{
  if (x - w /2 < paddleXL + paddleW /2 && y-h/2 < paddleYL + paddleW/2 && y + h/2 > paddleYL - paddleH/2) // Linker Schläger
  {
    if (speedX < 0)
    {
       speedX = -speedX;
    }     
  }

  
  else if (x + w /2 > paddleXR - paddleW /2 && y-h/2 < paddleYR + paddleW/2 && y + h/2 > paddleYR - paddleH/2) // Rechter Schläger
  {
    if (speedX > 0)
    {
        speedX = -speedX;
    }      
  } 
}





void restrictpaddle() // Überprüfung dass der Schläger nicht außerhalb des Bildschirmes gerät
{
 if (paddleYL - paddleH /2 < 0)
 {
    paddleYL = paddleYL + paddleS;  //für die obere Seite des Bildschirmes
 }
 
 if (paddleYL + paddleH /2 > height)
 {
    paddleYL = paddleYL - paddleS;  //für die untere Seite des Bildschirmes
 }
 
  if (paddleYR - paddleH /2 < 0)
 {
    paddleYR = paddleYR + paddleS;  //für die obere Seite des Bildschirmes
 }
 
 if (paddleYR + paddleH /2 > height)
 {
    paddleYR = paddleYR - paddleS;  //für die untere Seite des Bildschirmes
 } 
}



void drawCircle()
{
  
  if (Start == true)
  {
     fill(0);
     return;
  }
  
  else

    fill (255,0,0);
    ellipse(x,y,w,h);  
}


void moveCircle()
{
    x = x + speedX;
    y = y + speedY;
}


void bounceoff()
{
   if (x > width - w/2)
  {
    setup();   //Ruft die Neustartfunktion auf wenn der Ball das Speilfeld verlässt
    speedX = -speedX; //Damit der Ball das Spielfeld nicht verlässt(rechte Seite des Spielfeldes)    
    scoreL = scoreL + 1; // Wenn der Ball nicht vom Gegner abgefangen wird, bekommt der Gegner einen Punkt       
  }
  
  else if (x < 0 + w /2)
  {
    speedX = -speedX; //Damit der Ball das Spielfeld nicht verlässt(linke Seite des Spielfeldes)
    setup();  //Ruft die Neustartfunktion auf wenn der Ball das Speilfeld verlässt
    scoreR = scoreR + 1; // Wenn der Ball nicht vom Gegner abgefangen wird, bekommt der Gegner einen Punkt
  }
  
  if (y > height - h/2)
  {
    speedY = -speedY; //Damit der Ball das Spielfeld nicht verlässt(obere Seite des Spielfeldes)
  }
  
  else if (y < 0 + h/2)
  {
    speedY = -speedY;  //Damit der Ball das Spielfeld nicht verlässt(untere Seite des Spielfeldes)
  }  
}


void scores()
{   
    if (Start == true)
    {
       return; 
    }
    
  else
  
    fill(colorL);           //Farbe für ScoreL
    text(scoreL,30,50);
    String ausgabe = "ScoreL";
    text(ausgabe,30,30); 
    fill(colorR);           //Farbe für ScoreR
    String ausgabe2 = "ScoreR";
    text(ausgabe2,400,30);
    text(scoreR,400,50);
}

void ausgabe()
{
  if (Start == true)
  {
    return;
  }
  else
  
  fill(colorW);
  winscoreausgabe = "Aktueller  Winscore: 3";
  text(winscoreausgabe ,155,58);
  
  String ausgabe2 ="--------------------";
  text(ausgabe2,140,70); 
}





void gameOver() // Prozedur gameOver
{  
  
  if (Start == true)
  {
   fill(0);
   return;
  }
  
  else
  
    if (scoreL == winscore)  
    {
      gameoverpage("Grün hat gewonnen",colorL); 
    
      fill(255);
      text("----------------------------------------------",1,140);
      text("----------------------------------------------",1,370);      
      return;    
    }  
    
    if (scoreR == winscore)
    {             
      gameoverpage("Gelb hat gewonnen", colorR);
    
      fill(255);
      text("----------------------------------------------",1,140);
      text("----------------------------------------------",1,370); 
      return;   
    }
}


 void gameoverpage(String text ,color c)
{
    speedX = 0; //Schnelligkeit wird auf 0 zurückgesetzt!
    speedY = 0; //Schnelligkeit wird auf 0 zurückgesetzt!   
    
    fill(255);    
    fill(colorQ);
    String ausgabe = "GAME OVER";
    text(ausgabe,190,20);
  
    
    fill(c);
    text(text,160,100);   
    text("Hier klicken um neu zu starten " ,95,440);
    
    if (mousePressed)
    {
        scoreL = 0;
        scoreR = 0;
        setup();
    }      
    
    if (key == ENTER)
     {
        scoreL = 0;
        scoreR = 0;
        setup();
     }
}



void keyPressed()
{
  if (key == 'w' || key == 'W')   // Für linken Schläger
  {
      upL = true;
  }
  
  if (key == 's' || key == 'S')    // Für linken Schläger
  {
     downL = true; 
  }
  
  if (keyCode == UP )   // Für rechten Schläger
  {
     upR = true;
  }
  
  if (keyCode == DOWN)    // Für rechten Schläger
  {
     downR = true; 
  } 
  
  if (keyCode == RIGHT)
  {
     Start = true;
  }  
}

void keyReleased()
{
  if (key == 'w' || key == 'W')    // Für linken Schläger
  {
      upL = false;
  }
  
  if (key == 's' || key == 'S')    // Für linken Schläger
  {
      downL = false; 
  }
  
   if (keyCode == UP )   // Für rechten Schläger
  {
      upR = false;
  }
  
  if (keyCode == DOWN)    // Für rechten Schläger
  {
     downR = false; 
  }  
}


//////////////////////////

//QUELLENANGABEN:

// https://processing.org/examples/input -> Für Eingaben
// https://processing.org/examples/widthheight.html -> Für Höhe und Breite (Width and Height)
// https://processing.org/examples/mousefunctions.html -> Um Mouse Pressed Events auszulösen
// https://processing.org/examples/functions.html -> Für Funktionen mit/ohne Parameterübergabe
// https://processing.org/examples/color -> Für die Farbe
// http://www.farb-tabelle.de/de/farbtabelle.htm -> Für unterschiedliche Farbcodes  

//////////////////////////
