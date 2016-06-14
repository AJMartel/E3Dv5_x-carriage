headZ=16+5-1;

module funDuckBody() {
  hull() {
    translate([-(40+2)/2,25,-5+headZ])
      rotate([-asin((20-5)/42),0,0])
        cube([40+2,40+2,0.01]);
    translate([-10,0,0])
      cube([20,0.01,4]);
  }
  translate([-(40+2)/2,25,-5+headZ])
    rotate([-asin((20-5)/42),0,0])
      cube([40+2,40+2,10]);
}

difference(){
  rotate([0,0,180])  
    funDuckBody();
  rotate([0,0,180]) {
    difference() {
      cube([100,200,100],center=true);
      minkowski() {
        difference() {
          cube([100,200,100],center=true);
            funDuckBody(); 
        }
        cube(2,center=true);
      }
    }
    translate([-(40)/2,25+1,-5+headZ])
      rotate([-asin((20-5)/42),0,0])
        cube([40,40,10]);
    translate([-9,0,1])
        cube([18,5,2]);
  }
}
