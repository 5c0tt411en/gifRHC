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

  mov = new Movie(this, "mov/SCENE1.mov");
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
      gifDummy = new GifMaker(this, "exportedGIF/01/01/dummy.gif");
      gifDummy.setSize(width / 2, height / 2);
      gifDummy.setRepeat(0);
      gifDummy.setQuality(10);
      gifDummy.setDelay(80);
      gifExport01 = new GifMaker(this, "exportedGIF/01/01/02.gif");
      gifExport01.setSize(width / 2, height);
      gifExport01.setRepeat(0);
      gifExport01.setQuality(10);
      gifExport01.setDelay(80);
      gifExport02 = new GifMaker(this, "exportedGIF/01/01/01.gif");
      gifExport02.setSize(width / 2, height);
      gifExport02.setRepeat(0);
      gifExport02.setQuality(10);
      gifExport02.setDelay(80);
      /* gifExport03 = new GifMaker(this, "exportedGIF/01/35/03.gif"); */
      /* gifExport03.setSize(width / 2, height / 2); */
      /* gifExport03.setRepeat(0); */
      /* gifExport03.setQuality(10); */
      /* gifExport03.setDelay(80); */
      /* gifExport04 = new GifMaker(this, "exportedGIF/01/35/04.gif"); */
      /* gifExport04.setSize(width / 2, height / 2); */
      /* gifExport04.setRepeat(0); */
      /* gifExport04.setQuality(10); */
      /* gifExport04.setDelay(80); */
      timeStamp = float(millis()) / 1000;
      frameStamp = frameCount;
      mov.loop();
      stat = Status.BEGIN;
      break;
     case BEGIN:
     if (frame % 2 == 1) {
      for (int i = 2; i >= 0; i--) {
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
          /* textSize(40); */
          /* text(str((mov.time())), width / 2 - 10, height / 2 + 10); */
        popMatrix();
        switch (i % 5) {
          case 0: gifDummy.addFrame();    break;
          case 1: gifExport01.addFrame(); break;
          case 2: gifExport02.addFrame(); break;
          /* case 3: gifExport03.addFrame(); break; */
          /* case 4: gifExport04.addFrame(); break; */
          default:                        break;
        }
        /* delay(100); */
      /* if (i % 5 == 4) newFrame+=2; */
      /* setFrame(newFrame); */
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
      /* gifExport03.finish(); */
      /* gifExport04.finish(); */
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

void setFrame(int n) {
  mov.play();

  // The duration of a single frame:
  float frameDuration = 1.0 / mov.frameRate;

  // We move to the middle of the frame by adding 0.5:
  float where = (n + 0.5) * frameDuration;

  // Taking into account border effects:
  float diff = mov.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }

  mov.jump(where);
  mov.pause();
}
