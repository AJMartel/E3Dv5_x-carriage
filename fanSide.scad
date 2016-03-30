include <metric.scad>;
include <config.scad>;
use <functions.scad>;

module fan30mmScrewHoles(l=hotendFanHolderH+2) {
  for(x=[-1,1]) 
    for(y=[-1,1]) 
      translate([x*24/2,y*24/2,0]) {
        difference() {
          translate([0,0,-1])
            cylinder(d=screwM3D,h=l);
          translate([0,0,-0.2])
            cylinder(d=screwM3D+0.2,h=0.2);
        }
        rotate([0,0,-x*90])
          nutInsideHole(nutParams=nutM3,depth=8);
      }
}
module fan30mmScrewLugs(l=hotendFanHolderH+2) {
  for(x=[-1,1]) 
    for(y=[-1,1]) 
      translate([x*24/2,y*24/2,0]) 
          cylinder(d=nutM3D+2,h=l);
}
module centralPartDiff() {
  gpld=5;
  translate([0,0,-1])
    cylinder(d=radiatorD,h=radiatorL+1);
  cylinder(d=hotendNeckD,h=radiatorL+wallThickness+1);
  translate([1,0,radiatorL/2])
    rotate([0,-90,0])
      difference() {
        cylinder(r=fanHoleD/2, h=(carriageL-fanT)/2+2);
        for(m=[0,1])
        mirror([0,m,0]) {        
          translate([0,(radiatorD/2+(fanHoleD-radiatorD)/2),gpld/2])
            cube([fanHoleD,fanHoleD-radiatorD,gpld],center=true);
          translate([-fanHoleD/2,(radiatorD)/2,gpld])
            rotate([-6,0,0])
              cube([fanHoleD,fanHoleD-radiatorD,(carriageL-fanT)/2]);
        }
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
/*
  translate([-(carriageL-fanT)/2+4/2,0,radiatorL/2])
  cube([4,30,30],center=true);
*/
      translate([-(carriageL-fanT)/2,0,radiatorL/2])
        rotate([0,90,0])
          fanHolderLugs(h=(carriageL-fanT)/2-centralGap/2);
      translate([-(carriageL-fanT)/2,0,radiatorL/2])
        rotate([0,90,0])
          fan30mmScrewLugs(l=(carriageL-fanT)/2-centralGap/2);
      translate([0,0,radiatorL/2])
        bodyBevel(h2=(carriageL-fanT)/2-(radiatorD+2*wallThickness)/2);
      translate([0,0,radiatorL/2])
        rotate([180,0,0])
          bodyBevel(L=radiatorL/2,h1=radiatorL/2-(fanHoleD/2+wallThickness),d1Lip=4.5,d2Lip=0.1,h2=(carriageL-fanT)/2-(radiatorD+2*wallThickness)/2);
    }
    centralPartDiff();
  }
}

module fanSide() {
  difference() {
    union() {
      centralPart();
      for(m=[0,1])
        mirror([0,m,0]) {
          translate([-(carriageL-fanT)/2-+fanT,-25,(lm8uuD+4)/2])
            firstLM8UUholder(l=(carriageL-fanT)/2-centralGap/2+fanT);
          if (m==1) {
            gt2Plate(xTranslate=-((carriageL-fanT)/2+fanT)+gt2PlateL/2);
            hull() {
              translate([-((carriageL-fanT)/2+fanT),-(rodDst/2+14)+8/2+5-0.1,(lm8uuD+2*wallThickness)/2+2*wallThickness+14])
                cube([15,0.1,wallThickness]);
              translate([-(carriageL-fanT)/2+2,-fanHolderLugY,2*fanHolderLugX+(screwM2HeadD+2)/2])
                cube([15,0.1,wallThickness]);
            }
            hull() {
              translate([-((carriageL-fanT)/2+fanT),-(rodDst/2+14)+8/2+5-wallThickness,(lm8uuD+2*wallThickness)/2+14-2*wallThickness])
                cube([15,wallThickness,0.1]);
              translate([-((carriageL-fanT)/2+fanT),-rodDst/2-wallThickness/2,(lm8uuD+2*wallThickness)/2])
                cube([15,wallThickness,0.1]);
            }
        }
      
      }
    }
    translate([-(16/2+1.4),0,radiatorL/2])
      rotate([0,90,0])
        #holderMountScrewHoles();
    translate([-(carriageL-fanT)/2+fanScewL/2,0,radiatorL/2])
      rotate([0,-90,0])
        #fan30mmScrewHoles(l=16);
    for(y=[-1,1]) {
      translate([0,y*25,(lm8uuD+4)/2])
        rotate([0,-90,0]) {
          cylinder(h=(carriageL-fanT)/2+fanT-wallThickness, d=lm8uuD);
          #cylinder(h=(carriageL-fanT)/2+fanT+1, d=lm8uuD-2*wallThickness);
        }
    }
  }
}

fanSide();
// fan30mmScrewHoles(l=16);
