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

module gt2Plate() {
  gt2PlateL=15;
  gt2PlateTh=2*wallThickness;
  gt2PlateZ=(lm8uuD+2*wallThickness)/2-gt2PlateTh/2+14;
  translate([-(carriageL-fanT)/2+gt2PlateL/2,-(rodDst/2+14),gt2PlateZ])
  difference() {
    union() {
      translate([0,-((nutM2D+2*0.5)/2-5)/2,0])
        cube([gt2PlateL,(nutM2D+2*0.5)/2+8+5,gt2PlateTh],center=true);
      translate([0,-(8/2+3*(nutM2D+2*0.5)/4),0])
        cube([gt2PlateL-(nutM2D+2*0.5),(nutM2D+2*0.5)/2,gt2PlateTh],center=true);
      for(t=[-1,1])
        translate([t*(gt2PlateL-(nutM2D+2*0.5))/2,-(8/2+(nutM2D+2*0.5)/2),0])
          cylinder(d=(nutM2D+2*0.5),h=gt2PlateTh,center=true);
      translate([0,-(8/2+(nutM2D+2*0.5)/2),-gt2PlateTh/2])
        gt2NutGap();
      translate([0,8/2+5/2,gt2PlateTh/2+((3/2)*gt2PlateTh)/2])
        cube([gt2PlateL,5,(3/2)*gt2PlateTh],center=true);
    }
    translate([0,0,gt2PlateTh/2])
      cube([gt2PlateL+1,8,0.5+0.5],center=true);
    translate([0,8/2+5/2,gt2PlateTh/2+(gt2PlateTh)/2])
        cube([gt2PlateL-4*wallThickness,5+1,gt2PlateTh],center=true);
    translate([-(gt2PlateL-4*wallThickness)/2,8/2,(gt2PlateTh/2+(gt2PlateTh)/2)/2])
        rotate([-10,0,0])
          cube([gt2PlateL-4*wallThickness,5+1,gt2PlateTh/2]);
    translate([0,-(8/2+(nutM2D+2*0.5)/2),-(gt2PlateTh/2+nutM2H)]) {
      cylinder(h=10,d=screwM2D);
      cylinder(h=nutM2H,d=nutM2D, $fn=6);
    }
  }
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
    translate([16/2,0,radiatorL/2])
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
  