import processing.video.*;
Movie mov;

import gifAnimation.*;

GifMaker gifDummy, gifExport01, gifExport02, gifExport03, gifExport04;

int mode, transX, transY, newFrame, frame, frameStamp;
float time, timeStamp;
enum Status {BLANK, INIT, BEGIN, END}
Status stat;
String addr;
String[] adSp;

void setup(){
  stat = Status.BLANK;
  size(288, 224);
  noSmooth();
  frameRate(25);

  mov = new Movie(this, "mov/SCENE7.mov");
}

void draw(){
  frame = frameCount - frameStamp;
  time = float(millis()) / 1000 - timeStamp;

  switch (stat) {
    case BLANK:
      if (time >= 5.0) {
        timeStamp = float(millis()) / 1000;
        frameStamp = frameCount;
        stat = Status.INIT;
      }
      break;
    case INIT:
      gifDummy = new GifMaker(this, "exportedGIF/07/05/dummy.gif");
      gifDummy.setSize(width / 2, height / 2);
      gifDummy.setRepeat(0);
      gifDummy.setQuality(10);
      gifDummy.setDelay(80);
      gifExport01 = new GifMaker(this, "exportedGIF/07/05/02.gif");
      gifExport01.setSize(width / 2, height / 2);
      gifExport01.setRepeat(0);
      gifExport01.setQuality(10);
      gifExport01.setDelay(80);
      gifExport02 = new GifMaker(this, "exportedGIF/07/05/01.gif");
      gifExport02.setSize(width / 2, height / 2);
      gifExport02.setRepeat(0);
      gifExport02.setQuality(10);
      gifExport02.setDelay(80);
      gifExport03 = new GifMaker(this, "exportedGIF/07/05/03.gif");
      gifExport03.setSize(width / 2, height / 2);
      gifExport03.setRepeat(0);
      gifExport03.setQuality(10);
      gifExport03.setDelay(80);
      gifExport04 = new GifMaker(this, "exportedGIF/07/05/04.gif");
      gifExport04.setSize(width / 2, height / 2);
      gifExport04.setRepeat(0);
      gifExport04.setQuality(10);
      gifExport04.setDelay(80);
      timeStamp = float(millis()) / 1000;
      frameStamp = frameCount;
      mov.loop();
      stat = Status.BEGIN;
      break;
     case BEGIN:
     if (frame % 2 == 1) {
      for (int i = 4; i >= 0; i--) {
        switch (i % 5) {
          case 0: transX = 0; transY = 0;                       break;
          case 1: transX = 0; transY = 0;                       break;
          case 2: transX = - width / 2; transY = 0;             break;
          case 3: transX = 0; transY = - height / 2;            break;
          case 4: transX = - width / 2; transY = - height / 2;  break;
          default:                                              break;
        }
        pushMatrix();
          background(0);
          translate(transX, transY);
          background(0);
          image(mov, 64, 0, 224, 224);
        popMatrix();
        switch (i % 5) {
          case 0: gifDummy.addFrame();    break;
          case 1: gifExport01.addFrame(); break;
          case 2: gifExport02.addFrame(); break;
          case 3: gifExport03.addFrame(); break;
          case 4: gifExport04.addFrame(); break;
          default:                        break;
        }
      if (time > mov.duration()) {
        timeStamp = float(millis()) / 1000;
        frameStamp = frameCount;
        stat = Status.END;
      }
      }
      }
      break;
    case END:
      gifDummy.finish();
      gifExport01.finish();
      gifExport02.finish();
      gifExport03.finish();
      gifExport04.finish();
      exit();
      break;
    default:
      break;
  }
}

void movieEvent(Movie m) {
  m.read();
  mov.filter(THRESHOLD, 0.5);
}
