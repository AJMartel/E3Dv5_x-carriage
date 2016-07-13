include <config.scad>;

headZ=16+5-1;
distanceZ=5; //distance from bootom of carriage
totalZ=headZ-distanceZ;
duckLength=25-15+nutM2D+lm8uuD/2+wallThickness;
l = (40+2)/2-centralGap/2 - (nutM2W+4);

module fanDuckBody(sizeX=40+2) {
  difference() {
    hull() {
      translate([-sizeX/2,duckLength,0])
        cube([sizeX,40+2,totalZ]);
      translate([-sizeX/2,0,0])
        cube([sizeX,0.01,4]);
    }
    translate([-(sizeX+2)/2,duckLength+(40+2),totalZ/2])
      rotate([-90-45,0,0])
        #cube([sizeX+2,40+4,40+4]);
  }
  translate([-sizeX/2,duckLength,-5+headZ])
    cube([sizeX,40+2,10]); 
}

module diff() {
  difference() {
    cube([100,200,100],center=true);
    minkowski() {
      difference() {
        cube([101,201,101],center=true);
        fanDuckBody();
        translate([-(40+2)/2,-2,0])
          cube([40+2,5,4]);
      }
      cube(2,center=true);
    }
    for (x=[-1:1])
      translate([x*(40+2)/4,0,0])
        fanDuckBody(1);
  }
  translate([-(40)/2,duckLength+1,-5+headZ])
    cube([40,40,10]);
  
}

module holderTranslateX(l) {
  for (x=[-1,1])
    translate([x*l/2,0,0])
      children();
}

module fanDuck() {
  
  difference() {
    union() {
      fanDuckBody();
      translate([-(40+2)/4-centralGap/4-(nutM2W+4)/2,duckLength-nutM2D,0]) {
        difference() {
          union() {
            holderTranslateX(l) 
              difference() {
                cube([nutM2W+4,nutM2D,totalZ+10]);
                translate([2,-1,0])
                  cube([nutM2W,nutM2D+1,totalZ+10-2]);
              }
            translate([-l/2,0,totalZ+10-2]) {
              #cube([(40+2)/2-centralGap/2,nutM2D,2]);
              translate([0,0,-2-nutM2H])
                cube([(40+2)/2-centralGap/2,nutM2D,2]);
            }
          }
          holderTranslateX(l)
            translate([(nutM2W+4)/2,nutM2D/2,totalZ+10-2+0.2]) {
              #cylinder(d=screwM2D,h=2);
              translate([0,0,-2-nutM2H])
                #cylinder(d=screwM2D,h=2);
            }
        }
      }
    }
  }
}
/*
difference() {
  fanDuck();
  diff();
}
*/

strip();

module strip() {
  difference() {
    translate([-((40+2)-centralGap)/4,0,0])
      cube([(40+2)/2-centralGap/2,nutM2D,0.6]);
    holderTranslateX(l)
      translate([0,nutM2D/2,-1/2])
        #cylinder(d=screwM2D,h=2);
  }
}