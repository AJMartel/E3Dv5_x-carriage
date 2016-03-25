include <config.scad>

module bodyBevel1() {
  hull() {
    difference() {
      cylinder(d=radiatorD+2*wallThickness,h=5+5);
      translate([-10,-(radiatorD+2*wallThickness)/2-1,-1])
        cube([radiatorD+2*wallThickness+2,radiatorD+2*wallThickness+2,5+5+2]);
    }
    translate([-20,-0.1/2,0])
      cube([0.1,0.1,5]);
  }
}

module bodyBevel2(L=radiatorL/2+wallThickness, // Total length
                     d1=radiatorD+2*wallThickness,
                     d2=fanHoleD+2*wallThickness,
                     h1=radiatorL/2+wallThickness-(fanHoleD+2*wallThickness)/2,
                     h2=carriageL/2+hotendXtranslate-(radiatorD+2*wallThickness)/2,
                     d1Lip=5,
                     d2Lip=0.5) {
 translate([-(d1/2-d1Lip),0,L-h1-d2Lip])
 hull() {
    difference() {
      translate([d1/2-d1Lip,0,-L+h1+d2Lip])
        //cylinder(d=d1,h=h1+d2Lip);
        cylinder(d=d1,h=L);
      translate([0,-(d2+2)/2,-L+h1+d2Lip-1])
        cube([d1+1,d2+2,L+2]);
    }
    union() {
      difference() {
        translate([0,0,-d2/2+d2Lip])
          rotate([0,-90,0])
            cylinder(d=d2, h=h2+d1Lip);
        translate([-(h2+d1Lip+1)+0.5,-(d2+2)/2-1,-(d2-d2Lip+1)])
          cube([h2+d1Lip+1,d2+2,d2-d2Lip+1]);
      }
      translate([-(h2+d1Lip),-sqrt(pow(d2/2,2)-pow(d2/2-d2Lip,2)),-(L-h1-d2Lip)])
      cube([h2+d1Lip,2*sqrt(pow(d2/2,2)-pow(d2/2-d2Lip,2)),L-h1-d2Lip]);
    }
 }
}

bodyBevel2();
cylinder(d=radiatorD+2*wallThickness,h=radiatorL/2+wallThickness);
