import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class OriginalFractal extends PApplet {

int mag, panX, panY;

public void setup() {
  
  mag = 300;
  panX = 0;
  panY = 0;
}

public void draw() {
  noLoop();
  background(100);
  plotSet(mag, panX, panY);
  //fill(0);
  //stroke(10);
  //line(-width/2,0,width/2,0); //x axis
  //line(0,-height/2,0,height/2); //y axis
}

public void keyPressed() {
  println("pressed");
  if (key == ' ') {
    mag+=200;
    redraw();
  }
  switch(keyCode) {
    case UP: panY += 100;
      redraw();
      break;
    case DOWN: panY -= 100;
      redraw();
      break;
    case LEFT: panX += 100;
      redraw();
      break;
    case RIGHT: panX -= 100;
      redraw();
      break;
  }
}

public double[] testComplex(int iterations, double num, double inum) {
  //testing for complex numbers in set. c = num + i*inum
  double[] c = new double[2];
  if (iterations == 0) {
    c[0] = num;
    c[1] = inum;
  } else {
    double[] prev = testComplex(iterations-1,num,inum);
    c[0] = prev[0] * prev[0] - prev[1] * prev[1] + num;
    c[1] = 2 * prev[0] * prev[1] + inum;
  }
  return c;
}

public void plotSet(int magnitude, int pX, int pY) {
  translate(width/2+pX, height/2+pY);
  double scrX = (double) (width)/(magnitude*2);
  double shiftX = (double) pX/magnitude;
  double scrY = (double) (height)/(magnitude*2);
  double shiftY= (double) pY/magnitude;
  for (double x=-scrX-shiftX; x<scrX-shiftX; x+=scrX/1000) {
    //for (float x=-2; x<2; x+=0.002) {
    for (double y=-scrY-shiftY; y<scrY-shiftY; y+=scrY/1000) {
      //for (float y=-2; y<2; y+=0.002) {
      if (Math.sqrt(x*x+y*y)<=2) {
        double c = testComplex(80,x,y)[0];
        double i = testComplex(80,x,y)[1];
        String cS = String.valueOf(c);
        String iS = String.valueOf(i);
        if (!cS.equals("Infinity") && !cS.equals("NaN") && !iS.equals("Infinity") && !iS.equals("NaN")) {
          fill(0);
          noStroke();
          ellipse((float) x * magnitude,(float) y * magnitude, 1, 1);
        } else {
          int col = coloringNum(x,y);
          fill(255-(col-8)*8, (col+14)*7,80+(col-10)*4);
          noStroke();
          ellipse((float) x * magnitude, (float) y * magnitude, 1, 1);
        }
      }
    }
  }
}


public int coloringNum(double num, double inum) {
  //return # of iterations needed to reach 2 in any direction
  double c = num;
  double i = inum;
  int coloringIterations = 0;
  while (Math.abs(c) <= 5 || Math.abs(i) <= 5) {
    if (coloringIterations < 300) {
      double oldC = c;
      c = c * c - i * i + num;
      i = 2 * oldC * i + inum;
      coloringIterations++;
    } else {
      return 0;
    }
  }
  return coloringIterations;
}
  public void settings() {  size(1200,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "OriginalFractal" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
