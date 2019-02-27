
import processing.pdf.*;
import geomerative.*;

//TEXT
int indexPhraseSetFR;
int indexPhraseFR;
RFont font;
String [][]textTyped = {
  {"On me dit de te haïr et je m'y efforce", 
  "Je t'imagine cruel, violent, implacable", 
  "Mais à te voir je n'ai bientôt plus de force", 
  "Et de te blesser je suis bien incapable"}
  ,

  {"Tous mes camarades combattent avec rage", 
  "Et pleurent la nuit au souvenir des supplices", 
  "Infligés à leurs frères qui sont du même âge", 
  "et rêvent comme eux de toucher une peau lisse"}
};
boolean doSave = false;
RPoint [][]pnts;
float bottomLeftPointsXFR;
float bottomRightPointsXFR;
int LINE_SPACING = 80;

//SOUND
SoundManager sm;
int loop=0;
AudioPlayer background;
Minim minim;
boolean isTransitioning = false;
int startTime;

void setup() {
  size(1920, 1000);  
  // make window resizable
  surface.setResizable(true); 
  smooth();

  //TEXT
  RG.init(this);
  font = new RFont("FreeSans.ttf", 80, RFont.LEFT);
  RCommand.setSegmentStep(11);
  RCommand.setSegmentator(RCommand.UNIFORMSTEP);
  RCommand.setSegmentLength (10);


  //SOUND
  sm= new SoundManager(this);
  indexPhraseFR = 0;
  indexPhraseSetFR = -1;
  minim= new Minim(this);
  background = minim.loadFile("WAR.wav");

  // TIME
  startTime=millis();
}


void draw() {
  background(255);
  // margin border
  translate(150, 500);
  sm.update();
  background.setGain(-20);
  sm.drawText();
}
void nextPhrase() {
  //println(phraseSet[indexPhraseSet][indexPhrase]);
}

void nextPhraseSet() { 
    createPoint(textTyped[indexPhraseFR]);
}

void createPoint(String[] phrases) {
  pnts=new RPoint[phrases.length][];
  for (int i =0; i<phrases.length; i++) {
    // get the points on font outline
    RGroup grp;
    grp = font.toGroup(phrases[i]);
    grp = grp.toPolygonGroup();
    pnts[i] = grp.getPoints();
    grp.getBottomLeft();
    grp.getBottomRight();
    bottomLeftPointsXFR = grp.getBottomLeft().x;
    bottomRightPointsXFR = grp.getBottomRight().x;
  }
}
