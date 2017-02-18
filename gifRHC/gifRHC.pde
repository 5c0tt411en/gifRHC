import processing.video.*;
Movie mov;

import gifAnimation.*;

GifMaker gifDummy, gifExport01, gifExport02, gifExport03, gifExport04, gifExport05, gifExport06, gifExport07, gifExport08, gifExport09, gifExport10;

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
  if (time >= 0 && time < mov.duration() / 10) mode = 1;
  else if (time >= mov.duration() / 10 && time < 2 * mov.duration() / 10) mode = 2;
  else if (2 * time >= mov.duration() / 10 && time < 3 * mov.duration() / 10) mode = 3;
  else if (3 * time >= mov.duration() / 10 && time < 4 * mov.duration() / 10) mode = 4;
  else if (4 * time >= mov.duration() / 10 && time < 5 * mov.duration() / 10) mode = 5;
  else if (5 * time >= mov.duration() / 10 && time < 6 * mov.duration() / 10) mode = 6;
  else if (6 * time >= mov.duration() / 10 && time < 7 * mov.duration() / 10) mode = 7;
  else if (7 * time >= mov.duration() / 10 && time < 8 * mov.duration() / 10) mode = 8;
  else if (8 * time >= mov.duration() / 10 && time < 9 * mov.duration() / 10) mode = 9;
  else if (9 * time >= mov.duration() / 10 && time < mov.duration()) mode = 10;
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
      gifDummy = new GifMaker(this, "exportedGIF/01/time10/02/dummy.gif");
      gifDummy.setSize(width, height);
      gifDummy.setRepeat(0);
      gifDummy.setQuality(10);
      gifDummy.setDelay(80);
      gifExport01 = new GifMaker(this, "exportedGIF/01/time10/02/01.gif");
      gifExport01.setSize(width, height);
      gifExport01.setRepeat(0);
      gifExport01.setQuality(10);
      gifExport01.setDelay(80);
      gifExport02 = new GifMaker(this, "exportedGIF/01/time10/02/02.gif");
      gifExport02.setSize(width, height);
      gifExport02.setRepeat(0);
      gifExport02.setQuality(10);
      gifExport02.setDelay(80);
      gifExport03 = new GifMaker(this, "exportedGIF/01/time10/02/03.gif");
      gifExport03.setSize(width, height);
      gifExport03.setRepeat(0);
      gifExport03.setQuality(10);
      gifExport03.setDelay(80);
      gifExport04 = new GifMaker(this, "exportedGIF/01/time10/02/04.gif");
      gifExport04.setSize(width, height);
      gifExport04.setRepeat(0);
      gifExport04.setQuality(10);
      gifExport04.setDelay(80);
      gifExport05 = new GifMaker(this, "exportedGIF/01/time10/02/05.gif");
      gifExport05.setSize(width, height);
      gifExport05.setRepeat(0);
      gifExport05.setQuality(10);
      gifExport05.setDelay(80);
      gifExport06 = new GifMaker(this, "exportedGIF/01/time10/02/06.gif");
      gifExport06.setSize(width, height);
      gifExport06.setRepeat(0);
      gifExport06.setQuality(10);
      gifExport06.setDelay(80);
      gifExport07 = new GifMaker(this, "exportedGIF/01/time10/02/07.gif");
      gifExport07.setSize(width, height);
      gifExport07.setRepeat(0);
      gifExport07.setQuality(10);
      gifExport07.setDelay(80);
      gifExport08 = new GifMaker(this, "exportedGIF/01/time10/02/08.gif");
      gifExport08.setSize(width, height);
      gifExport08.setRepeat(0);
      gifExport08.setQuality(10);
      gifExport08.setDelay(80);
      gifExport09 = new GifMaker(this, "exportedGIF/01/time10/02/09.gif");
      gifExport09.setSize(width, height);
      gifExport09.setRepeat(0);
      gifExport09.setQuality(10);
      gifExport09.setDelay(80);
      gifExport10 = new GifMaker(this, "exportedGIF/01/time10/02/10.gif");
      gifExport10.setSize(width, height);
      gifExport10.setRepeat(0);
      gifExport10.setQuality(10);
      gifExport10.setDelay(80);
      timeStamp = float(millis()) / 1000;
      frameStamp = frameCount;
      mov.loop();
      stat = Status.BEGIN;
      break;
     case BEGIN:
     if (frame % 2 == 1) {
          background(0);
          image(mov, 64, 0, 224, 224);
        switch (mode) {
          case 0: gifDummy.addFrame();    break;
          case 1: gifExport01.addFrame(); break;
          case 2: gifExport02.addFrame(); break;
          case 3: gifExport03.addFrame(); break;
          case 4: gifExport04.addFrame(); break;
          case 5: gifExport05.addFrame(); break;
          case 6: gifExport06.addFrame(); break;
          case 7: gifExport07.addFrame(); break;
          case 8: gifExport08.addFrame(); break;
          case 9: gifExport09.addFrame(); break;
          case 10: gifExport10.addFrame(); break;
          default:                        break;
        }
      if (time > mov.duration()) {
        timeStamp = float(millis()) / 1000;
        frameStamp = frameCount;
        stat = Status.END;
      }
      }
      break;
    case END:
      gifDummy.finish();
      gifExport01.finish();
      gifExport02.finish();
      gifExport03.finish();
      gifExport04.finish();
      gifExport05.finish();
      gifExport06.finish();
      gifExport07.finish();
      gifExport08.finish();
      gifExport09.finish();
      gifExport10.finish();
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
