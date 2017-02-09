import gifAnimation.*;
import oscP5.*;
import netP5.*;

GifMaker gifExport;

OscP5 oscP5;

int mode, transX, transY;
float timeStamp, p1;
enum Status {BLANK, BEGIN, END}
Status stat;

void setup(){
  oscP5 = new OscP5(this,8000);
  stat = Status.BLANK;
  size(288, 225);
  noSmooth();
  frameRate(12.5);
}

void draw(){
  float time = float(millis()) / 1000 - timeStamp;
  background(0);

  pushMatrix();
  translate(transX, transY);
  ///////////////////////////////////////////////////////////////////
  text(str(time), 10, 10);
  ellipse(width * p1, height / 2, noise(time) * 100, noise(time) * 100);

  ///////////////////////////////////////////////////////////////////
  popMatrix();

  switch (stat) {
    case BLANK:
      break;
    case BEGIN:
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
  gifExport.setQuality(10);
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
      case 1: p1 = val; println(str(p1)); break;
      case 2: break;
      case 3: break;
      case 4: break;
      case 5: break;
      case 6: break;
      case 7: break;
      case 8: break;
      case 9: break;
      case 10: break;
      default: break;
    }
  }
}
