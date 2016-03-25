
$fa=0.1;
$fs=0.1;

R=3;
a=25;

module screwLug(r=3,a=25,h=10,th=2*3+4) {
  gap=th-2*r;
  xxx=gap+r*(1+sin(a));
  xx=r*cos(a);
  x=xx+xxx*tan(a);
  translate([0,0,-h/2])
    cylinder(r=r,h=h);
  hull() {
    translate([0,r+gap,0])
      cube([2*x,0.001,h],center=true);
    translate([0,-(xxx-r-gap),0])
      cube([2*xx,0.001,h],center=true);
  }
}

screwLug();