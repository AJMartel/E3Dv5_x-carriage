include <config.scad>;

module fanHolderLugs(h=8) {
  d=screwM2HeadD+2;
  fanHolderLugDstDiff=(fanHolderLugDst+wallThickness/2)/cos(fanHolderLugAngle)+1;
  for(m=[0,1])
    mirror([m,0,0])
      for(a=[-1,1])
        rotate([0,0,a*fanHolderLugAngle])
          union() {
            translate([fanHolderLugDst,0,0])
              cylinder(d=d,h=h);
            translate([0,-wallThickness/2,0])
              cube([fanHolderLugDst,wallThickness,h]);
          }
  difference() {
    cylinder(d=2*fanHolderLugDst+wallThickness,h=h);
    for(m=[0,1])
      mirror([m,0,0])
        hull()
          for(a=[-1,1])
            rotate([0,0,a*fanHolderLugAngle])
              translate([0,-0.5/2,-1/2])
                cube([fanHolderLugDstDiff,0.5,h+1]);
    translate([0,0,-0.5])
      cylinder(d=2*fanHolderLugDst-wallThickness,h=h+1);  
  }
}

module nutInsideHole(nutParams=nutM2,depth=10) {
  union() {
    rotate([0,0,90])
      cylinder(d=nutParams[2],h=nutParams[1], $fn=6);
    translate([-nutParams[0]/2,0,0])
      cube([nutParams[0],(depth-nutParams[2]/2),nutParams[1]]);
  }
}

module holderMountScrewHoles(l=16) {
  for(x=[-1,1]) 
    for(y=[-1,1]) 
      translate([x*fanHolderLugX,y*fanHolderLugY,0]) {
        difference() {
          translate([0,0,-1])
            cylinder(d=screwM2D,h=l-0.2+1);
          translate([0,0,nutM2H])
            cylinder(d=screwM2D+0.1,h=0.2);
        }
        translate([0,0,l])
          cylinder(d=screwM2HeadD,h=carriageL-hotendFanHolderH-l+1);
        rotate([0,0,-x*90])
          nutInsideHole(nutParams=nutM2,depth=8);
      }
}

module bodyBevel(L=radiatorL/2+wallThickness, // Total length
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

module gt2NutGap(d1=nutM2D+2*0.5,d2=nutM2D+2*0.5,gapL=15) {
  translateX=(gapL-d1)/2;
  hull() {
    union() {
      translate([0,0,0.1/2])
        cube([2*translateX,d1,0.1],center=true);
      for(x=[-1,1])
        translate([x*translateX,0,0])
          cylinder(d=d1,h=0.1);
    }
    translate([0,0,-nutM2H/2])
      cylinder(d=d2,h=0.1);
  }
}

module lm8uuHolderScrewLug(r=3,h=10,a=25, th=7) {
  gap=th-2*r;
  xxx=gap+r*(1+sin(a));
  xx=r*cos(a);
  x=xx+xxx*tan(a);
//  translate([0,h/2,0])
    rotate([90,0,0])
      hull() {
        cylinder(r=r,h=h,center=true);
        translate([0,r+gap,0])
          cube([2*x,0.001,h],center=true);
      }
}

module firstLM8UUholder(l=(carriageL-fanT)/2-centralGap/2) {
  screwLugH=holderNutTranslate+nutM2H/2+holderScrewTranslate;
  difference() {
    union() {
      rotate([0,90,0])
        cylinder(d=lm8uuD+2*wallThickness,h=l);
      translate([(carriageL-fanT)/4,screwLugH/2-holderScrewTranslate, -(lm8uuD)/2-wallThickness])
        lm8uuHolderScrewLug(r=(nutM2D+1)/2, h=screwLugH, a=40);
    }
 // translate([(carriageL-fanT)/4,(holderNutTranslate+nutM2H/2+holderScrewTranslate)/2-holderScrewTranslate,-(lm8uuD)/2-wallThickness])
    translate([(carriageL-fanT)/4,(screwLugH)/2-holderScrewTranslate,-(lm8uuD)/2-wallThickness])
      rotate([90,0,0]) 
        #cylinder(d=screwM2D,h=screwLugH+1,center=true);
    translate([(carriageL-fanT)/4,holderNutTranslate,-(lm8uuD)/2-wallThickness])
      rotate([-90,30,0])
        #cylinder(d=nutM2D,h=nutM2H,$fn=6);
    translate([(carriageL-fanT)/4,-holderScrewTranslate+screwM2HeadH/2,-(lm8uuD)/2-wallThickness])
      rotate([90,30,0])
        #cylinder(d=screwM2HeadD,h=screwM2HeadH);
    translate([l/2,0,-(lm8uuD)/2-wallThickness-0.5])
      #cube([l+1,1,(nutM2D+wallThickness)+2],center=true);
  }
}

module gt2Plate(xTranslate=-(carriageL-fanT)/2+gt2PlateL/2) {
  
  gt2PlateZ=(lm8uuD+2*wallThickness)/2-gt2PlateTh/2+14;
  translate([xTranslate,-(rodDst/2+14),gt2PlateZ])
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
holderMountScrewHoles();
//lm8uuHolderScrewLug();
//fanHolderLugs();