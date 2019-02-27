import ddf.minim.*;

String [][]soundNamesFR = {
  {"FR_01", "FR_02", "FR_03", "FR_04"}, 
  {"FR_05", "FR_06", "FR_07", "FR_08"}
};

class SoundManager {
  //SOUND
  Minim minim;
  AudioPlayer[][] soundsFR;

  float transitionTime = 0;
  int startTransitionTime;
  int transitionDuration = 1500;

  SoundManager(PApplet app) {

    minim = new Minim(app);
    soundsFR = new AudioPlayer[soundNamesFR.length][];
    // println(soundNamesFR.length);
    AudioPlayer [] phraseSoundsFR;
    for (int i =0; i<soundNamesFR.length; i++) {
      phraseSoundsFR = new AudioPlayer[soundNamesFR[i].length]; 
      for (int j=0; j<soundNamesFR[i].length; j++) {
        phraseSoundsFR[j] = minim.loadFile(soundNamesFR[i][j]+".wav", 512);
      }
      soundsFR[i]=phraseSoundsFR;
    }
  }

  void update() {

    if (isTransitioning) {
      if (millis() >= startTransitionTime+transitionDuration) {
        // transition end
        // si c'est pas fini on passe au suivant
        if (indexPhraseSetFR < soundsFR.length) {
          isTransitioning=false;
          transitionTime=0; 
          playSound();
          // si on a lu tous les groupes on recommence à zero
        } else if (indexPhraseSetFR == soundsFR.length && millis() >= startTransitionTime+transitionDuration) {         
          // reset from the beginning 
          isTransitioning=false;
          transitionTime=0;    
          indexPhraseSetFR=0;
          indexPhraseFR=0;
          nextPhrase();
          background.shiftGain(-20, -80, 1000);
          background.rewind();
          background.pause();
          startTime = millis();
          playSound();
          background.play();
          background.shiftGain(-80, -20, 1000);
        }
      } else if (millis() <= startTransitionTime+transitionDuration) {       
        //  we are transiting 
        transitionTime = map(millis(), startTransitionTime, startTransitionTime+transitionDuration, 0., 1.);
      }
    } else {
      if ( indexPhraseSetFR==-1 ) { 
        // Initialise all
        indexPhraseSetFR=0;
        indexPhraseFR=0;
        playSound();
        nextPhraseSet();
        background.play();
        background.shiftGain(-80, -20, 1000);
      } else if ( !soundsFR[indexPhraseSetFR][indexPhraseFR].isPlaying()) {  
        // sound file is finished read next one
        indexPhraseFR++;

        if ( isTransitioning==false &&  indexPhraseFR >= soundsFR[indexPhraseSetFR].length && indexPhraseSetFR <soundsFR.length) {
          // If phrases'index is greater than the stanza's index then go on to the next stanza
          nextPhraseSet();
          indexPhraseFR=0;// 1rst sentence
          indexPhraseSetFR++;// increase stanza's index
          isTransitioning = true;
          startTransitionTime = millis();
        } else {
        }
        if (millis() >= startTransitionTime+transitionDuration) {
          playSound();
        }
      } else { 
        // we're reading the sound file
      }
    }
  }

  void drawText(){ 
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
          println(i);
          //bezier(-2*(noise(5)), 2, 3*(noise(5)), -2, 5*noise(5), -4, 2, 6);
          popMatrix();
          }
        }
        // move to the next line
        translate(0, LINE_SPACING);
      }
    popMatrix();
  }


  void pauseSound() {
    AudioPlayer fr = soundsFR[indexPhraseSetFR][indexPhraseFR];
    fr.rewind();
    fr.pause();
  }

  void playSound() {
    AudioPlayer fr = soundsFR[indexPhraseSetFR][indexPhraseFR];
    fr.rewind(); 
    fr.play();
  }
}
