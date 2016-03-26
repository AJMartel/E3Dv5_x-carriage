include <metric.scad>;
include <config.scad>;
use <functions.scad>;

module centralPartDiff() {
  translate([0,0,-1])
    cylinder(d=radiatorD,h=radiatorL+1);
  cylinder(d=hotendNeckD,h=radiatorL+wallThickness+1);
  translate([-((carriageL-fanT)/2+1),0,radiatorL/2])
    rotate([0,90,0])
      difference() {
        cylinder(r=fanHoleD/2, h=(carriageL-fanT)/2+2);
        for(y=[-1,1])
          translate([0,y*(radiatorD/2+(fanHoleD-radiatorD)/2),(carriageL-fanT)/4+1])
            cube([fanHoleD,fanHoleD-radiatorD,(carriageL-fanT)/2+2],center=true);
      }
}

module centralPart() {
  difference() {
    union() {
      difference() {
        cylinder(d=radiatorD+2*wallThickness,h=radiatorL+wallThickness);
        translate([-centralGap/2,-(radiatorD+2*wallThickness+2)/2,-1])
          cube([radiatorD+2*wallThickness+centralGap/2+1,radiatorD+2*wallThickness+2,radiatorL+wallThickness+2]);
      } 
      translate([-centralGap/2,0,radiatorL/2])
        rotate([0,-90,0])
          cylinder(d=fanHoleD+2*wallThickness, h=(carriageL-fanT)/2-centralGap/2);
      translate([0,0,radiatorL/2])
        bodyBevel(h2=(carriageL-fanT)/2-(radiatorD+2*wallThickness)/2);
      translate([0,0,radiatorL/2])
        rotate([180,0,0])
          bodyBevel(L=radiatorL/2,h1=radiatorL/2-(fanHoleD/2+wallThickness),d1Lip=4.5,d2Lip=0.1,h2=(carriageL-fanT)/2-(radiatorD+2*wallThickness)/2);
      translate([-(carriageL-fanT)/2,0,radiatorL/2])
        rotate([0,90,0])
          fanHolderLugs(h=(carriageL-fanT)/2-centralGap/2);
    }
    centralPartDiff();
  }
}



module secondLM8UUholder() {
  translate([-(carriageL-fanT)/2,25,(lm8uuD+2*wallThickness)/2])
    rotate([0,90,0])
      cylinder(d=lm8uuD+2*wallThickness,h=(carriageL-fanT)/2-centralGap/2);
}

module anotherSide() {
  difference() {
    union() {
      centralPart();
//    translate([-(carriageL-fanT)/2,-25,(lm8uuD+2*wallThickness)/2])
      translate([-(carriageL-fanT)/2,-25,(lm8uuD+4)/2])
        rotate([0,0,0])
          firstLM8UUholder();
      gt2Plate();
        translate([-(carriageL-fanT)/2,25,(lm8uuD+4)/2])
          mirror([0,1,0])
            firstLM8UUholder();
      hull() {
        translate([-(carriageL-fanT)/2,-(rodDst/2+14)+8/2+5-0.1,(lm8uuD+2*wallThickness)/2+2*wallThickness+14])
          cube([15,0.1,wallThickness]);
        translate([-(carriageL-fanT)/2,-fanHolderLugY,2*fanHolderLugX+(screwM2HeadD+2)/2])
          cube([15,0.1,wallThickness]);
      }
      hull() {
        translate([-(carriageL-fanT)/2,-(rodDst/2+14)+8/2+5-wallThickness,(lm8uuD+2*wallThickness)/2+14-2*wallThickness])
          cube([15,wallThickness,0.1]);
        translate([-(carriageL-fanT)/2,-rodDst/2-wallThickness/2,(lm8uuD+2*wallThickness)/2])
          cube([15,wallThickness,0.1]);
      }
    }
//    translate([hotendFanHolderH-10,0,radiatorL/2])
    translate([16/2+1.4,0,radiatorL/2])
      rotate([0,-90,0])
        #holderMountScrewHoles();
    for(y=[-1,1]) {
      translate([0,y*25,(lm8uuD+4)/2])
        rotate([0,-90,0]) {
          cylinder(h=(carriageL-fanT)/2-wallThickness, d=lm8uuD);
          cylinder(h=(carriageL-fanT)/2+1, d=lm8uuD-2*wallThickness);
        }
    }
  }
}

/*
translate([0,-(rodDst/2+14),14])
   %cube([100,6,1.5],center=true);
*/
 anotherSide();

//firstLM8UUholder();
  