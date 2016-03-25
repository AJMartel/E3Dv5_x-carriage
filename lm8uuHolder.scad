include <config.scad>;
use <E3Dv5_x-carriage.scad>;
use <functions.scad>;


// translate([0,-14,14])
//   %cube([100,6,1.5],center=true);
  
/*
translate([-lm8uuL/2,-14,14-(2+0.5)/2-1.5/2+0.5])
difference() {
  cube([lm8uuL,6+2+2,2+0.5],center=true);
  translate([0,0,(2+0.5)/2])
    cube([lm8uuL+2,6+2,1],center=true);
}
*/

module gt2plate(fixW=5,beltW=8,thicknes=2, beltGrooveDepth=0.5) {
  union() {
    // Center side
    cube([2*lm8uuL,beltW,thicknes],center=true);
    // Screw side
    translate([0,-beltW/2,beltGrooveDepth/2])
      gt2plateSrew(thicknes=thicknes);
    // Fix side
    translate([0,beltW/2,-thicknes/2])
      gt2PlateFix(width=fixW,thicknes=thicknes, beltGrooveDepth=beltGrooveDepth);
  }
}

// gt2plate fix side
module gt2PlateFix(width=5,thicknes=2,beltGrooveDepth=0.5,GapL=15) {
  gapWallThickness=thicknes;
  gapWallXtranslate=lm8uuL+gapWallThickness/2-GapL;
  translate([0,width/2,(thicknes+beltGrooveDepth)/2])
    cube([2*lm8uuL,width,thicknes+beltGrooveDepth],center=true);
  translate([0,width/2,2*thicknes+beltGrooveDepth+thicknes/2])
    cube([2*lm8uuL,width,thicknes],center=true);
  for(x=[-1,1]) {
    translate([x*(lm8uuL-gapWallThickness/2),width/2,thicknes+beltGrooveDepth+thicknes/2])
      cube([gapWallThickness,width,thicknes],center=true);
    translate([x*gapWallXtranslate,width/2,thicknes+beltGrooveDepth+thicknes/2])
      cube([gapWallThickness,width,thicknes],center=true);
  }
}

// gt2plate screw side gap for nut
module gt2NutGap(d1=8,d2=nutM2D+2*0.5,halfGapL) {
  translateX=halfGapL-d1/2;
  hull() {
    union() {
      translate([0,0,0.1/2])
        cube([2*translateX,d1,0.1],center=true);
      for(x=[-1,1])
        translate([x*translateX,0,0])
          cylinder(d=d1,h=0.1);
    }
    translate([0,0,-nutM2H])
      cylinder(d=d2,h=0.1);
  }
}

// gt2plate screw side
module gt2plateSrew(thicknes=2,beltGrooveDepth=0.5,GapL=15) {
  width=8;
 // screwW=width;
  gapWallThickness=0.5;
  gapAngleX=20;
//  testAngle=atan(nutM2H/((width-nutM2D)/2-0.5));
//  halfGapL=(nutM2H/tan(gapAngleX)+nutM2D/2+gapWallThickness);
  halfGapL=GapL/2;
  translate([0,-width/2,0]) {
    difference() {
      union() {
        translate([0,width/4,0])
          cube([2*lm8uuL,width/2,thicknes+beltGrooveDepth],center=true);
        translate([0,-width/4,0])
          cube([2*lm8uuL-width,width/2,thicknes+beltGrooveDepth],center=true);
        for(t=[-1,1]){
          translate([t*(lm8uuL-width/2),0,-(thicknes+beltGrooveDepth)/2])
            cylinder(d=width,h=thicknes+beltGrooveDepth);
            translate([t*(lm8uuL-halfGapL),0,-(thicknes+beltGrooveDepth)/2])
              gt2NutGap(d1=width,d2=nutM2D+2*gapWallThickness,
                          halfGapL=halfGapL,gapWallThickness=gapWallThickness);
        }
      }
      for(t=[-1,1])
        translate([t*(lm8uuL-halfGapL),0,-(thicknes+beltGrooveDepth)/2-nutM2H-1]) {
          #cylinder(d=screwM2D, h=thicknes+beltGrooveDepth+nutM2H+2);
          #cylinder(d=nutM2D,h=nutM2H+1,$fn=6);
        }
    }
  }
}

module gt2plate2body(){
  yDistance=50/2+14-8/2-5-fanHolderLugY;
  zDistance=(2*fanHolderLugX+(screwM2HeadD+2)/2)-((lm8uuD+3)/2+14-(2)/2)-2*3;
  echo(zDistance);
  xAngle=atan(zDistance/yDistance);
  echo(xAngle);
  distance=yDistance/cos(xAngle);
  rotate([180+xAngle+1.5,0,0])
    translate([0,0,-wallThickness/2])
      cube([carriageL/2+hotendXtranslate,distance+4,wallThickness]);
}
//gt2NutGap(d=8,angleX=20);

//gt2plateSrew();

 translate([hotendXtranslate,0,radiatorL/2])
        rotate([0,-90,0])
          fanHolderLugs(h=carriageL/2+hotendXtranslate,th=wallThickness);
translate([0,-50/2,(lm8uuD+3)/2])
union() {
  lm8uuHolder();
  translate([0,-14,14-(2)/2])
    gt2plate();
}
//
  translate([-carriageL/2,-fanHolderLugY,radiatorL/2+fanHolderLugX])
      gt2plate2body();
      

