import ddf.minim.*;
Minim minim;
AudioInput in;

import gifAnimation.*;
import oscP5.*;
import netP5.*;

GifMaker gifExport01, ;

OscP5 oscP5;

int mode, transX, transY;
float time, timeStamp, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10;
enum Status {BLANK, BEGIN, END}
Status stat;

Sample_1[][] s1 = new Sample_1[10][40];

void setup(){
	minim = new Minim(this);
	in = minim.getLineIn(Minim.STEREO, 512);

  oscP5 = new OscP5(this,8000);
  stat = Status.BLANK;
  size(288, 224);
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
  background(0);

  switch (stat) {
    case BLANK:
      pushMatrix();
      translate(transX, transY);
    textSize(40);
    text("START", width / 2 - 60, height / 2 + 10);
  popMatrix();
      break;
    case BEGIN:
      pushMatrix();
      translate(transX, transY);
      ///////////////////////////////////////////////////////////////////
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
      gifExport.addFrame();
      break;
    case END:
      gifExport.finish();
      exit();
      break;
    default:
      break;
  }
}

void oscEvent(OscMessage theOscMessage) {
  String addr = theOscMessage.addrPattern();
  String[] adSp = split(addr, "/");

  if (adSp[1].equals("begin")) {
  gifExport = new GifMaker(this, "exportedGIF/03/0" + adSp[2] + ".gif");
  gifExport.setSize(width / 2, height / 2);
  gifExport.setRepeat(0);
  gifExport.setQuality(1);
  gifExport.setDelay(80);
      switch (int(adSp[2])) {
        case 1:
          transX = 0; transY = 0;
          break;
        case 2:
          transX = - width / 2; transY = 0;
          break;
        case 3:
          transX = 0; transY = - height / 2;
          break;
        case 4:
          transX = - width / 2; transY = - height / 2;
          break;
        default:
          break;
      }
      for(int i = 0; i < 20; i++) {
        gifExport.addFrame();
        delay(100);
      }
    timeStamp = float(millis()) / 1000;
    stat = Status.BEGIN;
  }
  else if (adSp[1].equals("end")) {
    timeStamp = float(millis()) / 1000;
    stat = Status.END;
  }
  else if (adSp[1].equals("param")) {
    float  val = theOscMessage.get(0).floatValue();
    switch (int(adSp[2])) {
      case 1: p1 = val; break;
      case 2: p2 = val; break;
      case 3: p3 = val; break;
      case 4: p4 = val; break;
      case 5: p5 = val; break;
      case 6: p6 = val; break;
      case 7: p7 = val; break;
      case 8: p8 = val; break;
      case 9: p9 = val; break;
      case 10: p10 = val; break;
      default: break;
    }
  }
}


void stop() {
	in.close();
	minim.stop();
	super.stop();
}
