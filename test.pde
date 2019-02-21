double ten = 10, zero = 0;
double inf = ten/zero;
double nan = inf*zero;

println(inf);
println(nan);

String infS = String.valueOf(inf);
String nanS = String.valueOf(nan);

println(infS);
println(nanS);
println(infS.equals("Infinity"));
println(nanS.equals("NaN"));
