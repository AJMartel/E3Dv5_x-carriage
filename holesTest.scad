include <config.scad>;
use <fanHolder.scad>;

difference() {
  union() {
    cylinder(d=lm8uuD+4, h=6);
    translate([0,-(lm8uuD+4)/2,0])
      cube([lm8uuD/2+2+nutM2W+2+nutM3W+2, lm8uuD+4, 6]);
  }
  translate([0,0,-1])
    cylinder(d=lm8uuD,h=6+2);
  translate([lm8uuD/2+2+nutM3W/2,0,-1])
    cylinder(d=screwM3D,h=6+2);
  translate([lm8uuD/2+2+nutM3W/2,0,6/2-nutM3H/2])
    #nutInsideHole(nutM3,14);
  translate([lm8uuD/2+2+nutM3W+2+nutM2W/2,0,-1])
    cylinder(d=screwM2D,h=6+2);
  translate([lm8uuD/2+2+nutM3W+2+nutM2W/2,0,6/2-nutM2H/2])
    #nutInsideHole(nutM2,14);
}