void setup() {
  double ten = 10, zero = 0;
  double inf = ten/zero;
  double nan = inf*zero;

  println(inf);
  println(nan);

  String infS = "" + inf;
  String nanS = "" + nan;

  println(infS);
  println(nanS);
  println(infS.equals("Infinity"));
  println(nanS.equals("NaN"));
}
