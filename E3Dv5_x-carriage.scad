include<config.scad>
use <functions.scad>
use <fanHolder.scad>
use <bodyBevel.scad>



// Spetial settings
//hotendXtranslate=carriageL/2-hotendFanHolderH-10; // Radiator -> Fan distance = 5mm
//hotendXtranslate=0;

/*
translate([hotendXtranslate,0,0])
  color("LightSlateGray") %import("E3Dv5.stl");
*/
for(i=[-1,1]) {
  translate([0,i*25,15/2+2,])
    rotate([0,90,0]){
      %cylinder(r=4, h=100,center=true);
      %cylinder(r=lm8uuD/2,h=80,center=true);
    }
}

module fan30mm() {
    difference() {
      cube([10,30,30],center=true);
      fan30mmScrewHoles();
    }
}

module lm8uuHolderScrewLug(r=3,h=10,a=25, th=7) {
  gap=th-2*r;
  xxx=gap+r*(1+sin(a));
  xx=r*cos(a);
  x=xx+xxx*tan(a);
  translate([0,0,-h/2])
    cylinder(r=r,h=h);
  hull() {
    translate([0,r+gap,0])
      cube([2*x,0.001,h],center=true);
    translate([0,-(xxx-r-gap),0])
      cube([2*xx,0.001,h],center=true);
  }
}

module lm8uuHolder() {
  hh = 0;
  holderNutTranslate = sqrt(pow(lm8uuD/2+wallThickness,2)-pow((lm8uuD/2+wallThickness+hh)-nutM2W/2,2));
  holderScrewTranslate = sqrt(pow(lm8uuD/2+wallThickness,2)-pow((lm8uuD/2+wallThickness+hh)-screwM2HeadD/2,2));
    echo(holderScrewTranslate);
  difference() {
    union() {
 /*
      translate([0,-(lm8uuD+4)/4+(holderNutTranslate+2)/2,0])
        cube([2*lm8uuL,(lm8uuD+4)/2+holderNutTranslate+2,lm8uuD+4],center=true);
 */
  
      rotate([0,90,0])
        cylinder(d=lm8uuD+2*wallThickness,h=2*lm8uuL,center=true);
      for(t=[-1,1]) {
        translate([t*lm8uuL/2,(holderNutTranslate+nutM2H/2+holderScrewTranslate)/2-holderScrewTranslate,-(lm8uuD)/2-wallThickness])
          rotate([90,0,0])
            lm8uuHolderScrewLug(r=(nutM2D+1)/2, h=holderNutTranslate+nutM2H/2+holderScrewTranslate, a=30);
      }
    }
    rotate([0,90,0])
      cylinder(d=lm8uuD,h=2*lm8uuL+1,center=true);
    for(t=[-1,1]) {
      translate([t*lm8uuL/2,0,-(lm8uuD)/2-wallThickness]) {
        rotate([90,0,0]) {
          translate([0,0,-holderNutTranslate])
            cylinder(d=nutM2D,h=nutM2H+0.5,center=true,$fn=6);
          translate([0,0,holderScrewTranslate])
            union() {
              cylinder(d=screwM2HeadD,h=screwM2HeadH+0.5,center=true);
              translate([0,0,-(12+screwM2HeadH)/2])
              cylinder(d=screwM2D,h=12,center=true);
            }
        }
      }
    }
    translate([0,0,-(lm8uuD)/2-wallThickness-0.5])
      #cube([2*lm8uuL+2,1,(nutM2D+1)+1],center=true);
  }
}

/*
module bodyBevel() {
  
}
*/
module centralPart() {
  difference() {
    union() {
      difference() {
        cylinder(d=radiatorD+2*wallThickness,h=radiatorL+wallThickness);
        translate([0,-(fanHoleD+2)/2,-1])
          cube([fanHoleD/2+1,fanHoleD+2,radiatorL+wallThickness+2]);
      }
      translate([0,0,radiatorL/2])
        rotate([0,-90,0])
          cylinder(d=fanHoleD+2*wallThickness, h=carriageL/2+hotendXtranslate);
      translate([0,0,radiatorL/2])
        rotate([0,-90,])
          fanHolderLugs(h=carriageL/2+hotendXtranslate,th=wallThickness);
      translate([0,0,radiatorL/2])
        bodyBevel2(d1Lip=4.5,d2Lip=0.1);
      translate([0,0,radiatorL/2])
        rotate([180,0,0])
          bodyBevel2(L=radiatorL/2,h1=radiatorL/2-(fanHoleD/2+wallThickness),d1Lip=4.5,d2Lip=0.1);
/*
      rotate([0,-90,0])
        for(x=[-1,1]) 
          for(y=[-1,1]) 
            translate([x*fanHolderLugX+radiatorL/2,y*fanHolderLugY,0]) {
              cylinder(d=screwM2HeadD+2,h=8);
        } */
    }
    translate([0,0,-1])
      cylinder(r=radiatorD/2,h=radiatorL+1);
    #cylinder(d=hotendNeckD,h=radiatorL+wallThickness+1);
    translate([0,0,radiatorL/2])
      rotate([0,90,0])
        difference() {
          #cylinder(r=fanHoleD/2, h=50+2, center=true);
            for(y=[-1,1])
              translate([0,y*(radiatorD/2+(fanHoleD-radiatorD)/2),-1])
                cube([fanHoleD,fanHoleD-radiatorD,50+2],center=true);
        }
    translate([hotendFanHolderH-10,0,radiatorL/2])
      rotate([0,-90,0])
        #holderMountScrewHoles(l=16);
  }
}

module body() {
  union() {
    for(i=[0,1]) {
      mirror([0,i,0])
      translate([0,-50/2,(lm8uuD+4)/2])
        lm8uuHolder();
    }
    translate([hotendXtranslate,0,0])
        centralPart();
  }
/*
  difference() {
    union() {
      for(i=[0,1]) {
        mirror([0,i,0])
        translate([0,-50/2,(lm8uuD+4)/2])
          lm8uuHolder();
      }
 
      difference() {
        translate([hotendXtranslate,0,0])
          cylinder(d=radiatorD+2*wallThickness,h=radiatorL);
  //      cube[(radiatorD+2*wallThickness+0.2)/2,radiatorD+2*wallThickness+0.2,
      }
      translate([hotendXtranslate-(carriageL/2+hotendXtranslate)/2,0,radiatorL/2])
        rotate([0,90,0])
          cylinder(d=28+2*wallThickness, h=carriageL/2+hotendXtranslate, center=true);
      /*
      translate([hotendXtranslate-(carriageL/2+hotendXtranslate)/2,0,radiatorL/2])
        //cube([carriageL/2+hotendXtranslate,50-lm8uuD,radiatorL],center=true);
      /*
    }
    translate([hotendXtranslate,0,-1])
      cylinder(r=25/2,h=radiatorL+2);
    translate([0,0,radiatorL/2])
      rotate([0,90,0])
        cylinder(r=28/2, h=50+2, center=true);
  }
 */
}

body();
//translate([0,-50/2,(lm8uuD+4)/2])
//lm8uuHolder();

//translate([(carriageL/2-10-0.1-hotendXtranslate)/2+hotendXtranslate+0.5,0,radiatorL/2])
/*
translate([hotendFanHolderH+hotendXtranslate,0,radiatorL/2])
  rotate([0,-90,0])
    color("red")
      %hotendFanHolder();
*/

/*
translate([0,60,0]) {
  centralPart();
}    
*/
/*
translate([lm8uuL-10/2,0,radiatorL/2])
  color("blue")
    %fan30mm();
*/
/*
translate([0,(50-lm8uuD)/2-2+screwD/2+2,0])
  rotate([0,90,0])
    color("red") cylinder(d=screwD, h=55, center=true); 
*/