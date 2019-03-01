import ddf.minim.*;

String []soundNamesFR = {
  "FR_01", "FR_02", "FR_03", "FR_04", 
  "FR_05", "FR_06", "FR_07", "FR_08"
};

class SoundManager {
  //SOUND
  Minim minim;
  AudioPlayer[] soundsFR;

  float transitionTime = 0;
  int startTransitionTime;
  int transitionDuration = 1500;


  SoundManager(PApplet app) {

    minim = new Minim(app);
    soundsFR = new AudioPlayer[soundNamesFR.length];    
    for (int j=0; j<soundNamesFR.length; j++) {
      soundsFR[j] = minim.loadFile(soundNamesFR[j]+".wav", 512);
    }
  }

  void update() {
    if (indexPhraseFR==0) {
      soundsFR[0].play();
      nextPhraseSet();
    }
    if (indexPhraseFR <= soundsFR.length && !soundsFR[indexPhraseFR].isPlaying()) {  
      // sound file is finished read next one
      nextPhraseSet();
      soundsFR[indexPhraseFR = (indexPhraseFR+1)% soundsFR.length].play();
    } 
    println(indexPhraseFR);
  }

  void drawText() { 
    // TEXT FR

    pushMatrix();
    // draw phrases vertically centered by moving the top up by half the line spaces
    translate(0, -1.0*LINE_SPACING*(pnts.length-1)/2.0);
    // loop through lines
    for (int i=0; i< pnts.length; i++) {
      // draw a line
      if (i%4==0) {
        translate(0, 50);
      }
      println(indexPhraseFR);
      if (indexPhraseFR>=i) {
        for (int j=0; j< pnts[i].length; j++) {
          pushMatrix();
          translate(pnts[i][j].x, pnts[i][j].y);
          noFill();
          stroke(0, 200);
          strokeWeight(0.5);
          float angle = TWO_PI*10;
          //rotate (j/angle*frameCount/10);
          rotate (j/angle*5*frameRate/5);
          line(0, 0, 5, 5);
          //println(i);
          //bezier(-2*(noise(5)), 2, 3*(noise(5)), -2, 5*noise(5), -4, 2, 6);
          popMatrix();
        }
      }
      // move to the next line
      translate(0, LINE_SPACING);
    }
    popMatrix();
  }


  /* void pauseSound() {
   AudioPlayer fr = soundsFR[indexPhraseFR];
   fr.rewind();
   fr.pause();
   }
   
   void playSound() {
   AudioPlayer fr = soundsFR[indexPhraseFR];
   fr.rewind(); 
   fr.play();
   }*/
}
