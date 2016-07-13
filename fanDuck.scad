include <config.scad>;
use <functions.scad>;
use <fanDuck2.scad>;

module fanDuckGhost() {  
  import("stl/fanSide.stl", convexity=3);
  rotate([0,0,180])
    import("stl/anotherSide.stl", convexity=3);
  translate([0,0,-16])
    rotate([0,0,180])
      hotend();
  %translate([0,0,-2-21])
    cube([100,1000,4],center=true);
}

 
 module hotend() {
   cylinder(h=16,d=4.6);
   translate([-15.25/2,-15.6,0])
     cube([15.25,20.25,12]);
   translate([0,0,-3])
     cylinder(d=7/cos(30), h=3, $fn=6);
   translate([0,0,-5])
     cylinder(d1=1, d2=4, h=2);
 }

 %fanDuckGhost();
 //translate([0,-15,-20]) {
 translate([0,-15,-20]) {    
   //import("stl/fanDuck2.stl", convexity=3);
   rotate([0,0,180])
     fanDuck();
}
