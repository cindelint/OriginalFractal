int mag;

public void setup() {
  mag = 300;
  background(100);
  size(1000,800);
  translate(width/2, height/2);
  plotSet(mag);
  fill(0);
  stroke(10);
  line(-width/2,0,width/2,0);
  line(0,-height/2,0,height/2);
}

public void draw() {}

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
  for (float x=-2; x<=0.5; x+=0.004) {
    for (float y=-2; y<=2; y+=0.004) {
      double c = testComplex(80,x,y)[0];
      double i = testComplex(80,x,y)[1];
      if (!Double.isInfinite(c) && !Double.isNaN(c) && !Double.isInfinite(i) && !Double.isNaN(i)) {
        fill(255);
        noStroke();
        ellipse((float) x * magnitude,(float) y * magnitude,1,1);
      }
    }
  }
}
