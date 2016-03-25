$fa=0.5;
$fs=0.5;

union() {
  for(i=[0:1:9]) {
    translate([0,0,i*3.4])
      cylinder(r=25/2,h=3.4-2.2);
  }
  cylinder(r=9.0/2,h=50.1);
  cylinder(r=13.0/2,h=3.4*6);
  cylinder(r=15.0/2,h=3.4*5);
  translate([0,0,50.1-14.6-1.5])
    cylinder(r=16.0/2,h=1.5);
  translate([0,0,50.1-12.3])
    cylinder(r=12.0/2,h=12.3);
  translate([0,0,50.1-9.3-(12.3-9.3)])
    cylinder(r=16.0/2,h=12.3-9.3);
  translate([0,0,50.1-3.7])
    cylinder(r=16.0/2,h=3.7);
}