include <config.scad>;

// Some tests for begin
nozzleHead=5;
rotate([0,0,180])
  %import("stl/fanSide.stl", convexity=3);
%import("stl/anotherSide.stl", convexity=3);

translate([0,20+25+10,5])
  cube([40,40,10],center=true);

translate([0,0,-21+2/2])
  cube([20,0.1,2],center=true);
translate([0,25,-21+2/2])
  cube([20,0.1,2],center=true);
 
 translate([5,25-2,lm8uuD+2+1])
   cylinder(d=nutM2D,h=nutM2H, $fn=6);