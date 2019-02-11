int mag;

public void setup() {
  size(1200,800);
  mag = 300;
}

public void draw() {
  noLoop();
  background(100);
  translate(width/2, height/2);
  plotSet(mag);
  //fill(0);
  //stroke(10);
  //line(-width/2,0,width/2,0); //x axis
  //line(0,-height/2,0,height/2); //y axis
}

public void keyPressed() {
  println("pressed");
  mag+=200;
  redraw();
}

public double[] testComplex(int iterations, float num, float inum) {
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

public void plotSet(int magnitude) {
  double inf = Double.POSITIVE_INFINITY;
  println(-width/(magnitude*2));
  for (float x=-width/(magnitude*2); x<width/(magnitude*2); x+=width/(magnitude*2000)) {
    //for (float x=-2; x<2; x+=0.002) {
    for (float y=-height/(magnitude*2); y<height/(magnitude*2); y+=height/(magnitude*2000)) {
      //for (float y=-2; y<2; y+=0.002) {
      if (Math.sqrt(x*x+y*y)<=2) {
        double c = testComplex(80,x,y)[0];
        double i = testComplex(80,x,y)[1];
        if (!Double.isInfinite(c) && !Double.isNaN(c) && !Double.isInfinite(i) && !Double.isNaN(i)) {
          fill(0);
          noStroke();
          ellipse((float) x * magnitude,(float) y * magnitude, 1, 1);
        } else {
          int col = coloringNum(x,y);
          fill(255-(col-6)*8, (col+15)*7,80+(col-10)*4);
          noStroke();
          ellipse((float) x * magnitude, (float) y * magnitude, 1, 1);
        }
      }
    }
  }
}


public int coloringNum(float num, float inum) {
  //return # of iterations needed to reach 2 in any direction
  float c = num;
  float i = inum;
  int coloringIterations = 0;
  while (Math.abs(c) <= 5 || Math.abs(i) <= 5) {
    if (coloringIterations < 300) {
      float oldC = c;
      c = c * c - i * i + num;
      i = 2 * oldC * i + inum;
      coloringIterations++;
    } else {
      return 0;
    }
  }
  return coloringIterations;
}
