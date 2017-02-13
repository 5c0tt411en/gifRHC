import ddf.minim.*;
Minim minim;
AudioInput in;

import gifAnimation.*;
import oscP5.*;
import netP5.*;

GifMaker gifExport01, gifExport02, gifExport03, gifExport04;

OscP5 oscP5;

int mode, transX, transY;
float time, timeStamp, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10;
enum Status {BLANK, INIT, BEGIN, END}
Status stat;
String addr;
String[] adSp;

Sample_1[][] s1 = new Sample_1[10][40];

void setup(){
	minim = new Minim(this);
	in = minim.getLineIn(Minim.STEREO, 512);

  oscP5 = new OscP5(this,8000);
  stat = Status.BLANK;
  size(288, 224, OPENGL);
  ortho();
  noSmooth();
  frameRate(12.5);

	for (int i = 0; i < s1.length; i++) {
		float transX = i * width / 40;
		float transY = i * height / 40;
		float rArray = i / 100;
		for (int j = 0; j < s1[0].length; j++) {
			s1[i][j] = new Sample_1(transX, -height / 4 + height / 20 * i, PI / 25 * j, rArray);
		}
	}
}

void draw(){
  time = float(millis()) / 1000 - timeStamp;

  switch (stat) {
    case BLANK:
      background(0);
      textSize(40);
      text("START", width / 2 - 60, height / 2 + 10);
      break;
    case INIT:
      pushMatrix();
      translate(transX, transY);
      background(0);
      textSize(40);
      text("START", width / 2 - 60, height / 2 + 10);
      popMatrix();
      gifExport01 = new GifMaker(this, "exportedGIF/03/01.gif");
      gifExport01.setSize(width / 2, height / 2);
      gifExport01.setRepeat(0);
      gifExport01.setQuality(1);
      gifExport01.setDelay(80);
      gifExport02 = new GifMaker(this, "exportedGIF/03/02.gif");
      gifExport02.setSize(width / 2, height / 2);
      gifExport02.setRepeat(0);
      gifExport02.setQuality(1);
      gifExport02.setDelay(80);
      gifExport03 = new GifMaker(this, "exportedGIF/03/03.gif");
      gifExport03.setSize(width / 2, height / 2);
      gifExport03.setRepeat(0);
      gifExport03.setQuality(1);
      gifExport03.setDelay(80);
      gifExport04 = new GifMaker(this, "exportedGIF/03/04.gif");
      gifExport04.setSize(width / 2, height / 2);
      gifExport04.setRepeat(0);
      gifExport04.setQuality(1);
      gifExport04.setDelay(80);
      for(int i = 0; i < 20; i++) {
        gifExport01.addFrame();
        gifExport02.addFrame();
        gifExport03.addFrame();
        gifExport04.addFrame();
        delay(100);
      }
      timeStamp = float(millis()) / 1000;
      stat = Status.BEGIN;
      break;
    case BEGIN:
      for (int n = 1; n <= 4; n++) {
        switch (n) {
          case 1: transX = 0; transY = 0;                       break;
          case 2: transX = - width / 2; transY = 0;             break;
          case 3: transX = 0; transY = - height / 2;            break;
          case 4: transX = - width / 2; transY = - height / 2;  break;
          default:                                              break;
        }
        pushMatrix();
        translate(transX, transY);
        ///////////////////////////////////////////////////////////////////
        background(0);
        textSize(40);
        text(str(time), width / 2 - 120, height / 2 + 10);
        s1[0][0].displaySample_1();
	      for (int i = 0; i < s1.length; i++) {
		      s1[i][0].revolve();
		      for(int j = 0; j < s1[0].length; j++) {
			      s1[i][j].drawCubes();
		      }
	      }
        ///////////////////////////////////////////////////////////////////
        popMatrix();
        switch (n) {
          case 1: gifExport01.addFrame(); break;
          case 2: gifExport02.addFrame(); break;
          case 3: gifExport03.addFrame(); break;
          case 4: gifExport04.addFrame(); break;
          default:                        break;
        }
      }
      break;
    case END:
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

void oscEvent(OscMessage theOscMessage) {
  addr = theOscMessage.addrPattern();
  adSp = split(addr, "/");

  if (adSp[1].equals("begin")) {
    timeStamp = float(millis()) / 1000;
    stat = Status.INIT;
  }
  else if (adSp[1].equals("end")) {
    timeStamp = float(millis()) / 1000;
    stat = Status.END;
  }
  else if (adSp[1].equals("param")) {
    float  val = theOscMessage.get(0).floatValue();
    switch (int(adSp[2])) {
      case 1:   p1 = val;   break;
      case 2:   p2 = val;   break;
      case 3:   p3 = val;   break;
      case 4:   p4 = val;   break;
      case 5:   p5 = val;   break;
      case 6:   p6 = val;   break;
      case 7:   p7 = val;   break;
      case 8:   p8 = val;   break;
      case 9:   p9 = val;   break;
      case 10:  p10 = val;  break;
      default:              break;
    }
  }
}


void stop() {
	in.close();
	minim.stop();
	super.stop();
}
