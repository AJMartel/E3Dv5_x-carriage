include<config.scad>

module nutInsideHole(nutParams=nutM2,depth=10) {
  union() {
    rotate([0,0,90])
      cylinder(d=nutParams[2],h=nutParams[1], $fn=6);
    translate([-nutParams[0]/2,0,0])
      cube([nutParams[0],(depth-nutParams[2]/2),nutParams[1]]);
  }
}

module fan30mmScrewHoles(l=hotendFanHolderH+2) {
  for(x=[-1,1]) 
    for(y=[-1,1]) 
      translate([x*24/2,y*24/2,0]) {
        translate([0,0,-l+nutM3H+1])
          cylinder(d=screwM3D,h=l);
        rotate([0,0,-x*90])
          nutInsideHole(nutParams=nutM3,depth=8);
      }
}

module nutShell(nutParams=nutM2) {
  union() {
    for(t=[-1,1])
    translate([0,0,t*nutParams[1]/2])
      sphere(d=nutParams[2]+2);
    cylinder(d=nutParams[2]+2,h=nutParams[1],center=true);
  }
}
module holderMountScrewHoles(l=16) {
  for(x=[-1,1]) 
    for(y=[-1,1]) 
      translate([x*fanHolderLugX,y*fanHolderLugY,0]) {
        translate([0,0,-1])
          cylinder(d=screwM2D,h=l-0.2+1);
        translate([0,0,l])
          cylinder(d=screwM2HeadD,h=carriageL-hotendFanHolderH-l+1);
        rotate([0,0,-x*90])
          nutInsideHole(nutParams=nutM2,depth=8);
      }
}

module fanBevel(h=hotendFanHolderH-centralGap) {
  hull() {
    cube([radiatorL,0.1,0.01]);
    translate([0,0,h-5])
      cube([radiatorL,(28-radiatorD)/2+0.1,0.01]);
  }
}
//bevel();

module hotendFanHolder() {
  holderH=hotendFanHolderH-centralGap;
  difference() {
    union() {
      difference() {
        translate([0,0,holderH/2])
          cube([radiatorL,50-lm8uuD,holderH],center=true);
        translate([0,0,-1])
          cylinder(r=28/2, h=holderH+2);
      }
      for(m=[0,1])
        mirror([0,m*1,0])
          translate([-radiatorL/2,-28/2-0.1,5])
            fanBevel(holderH);
    }
    translate([0,0,hotendFanHolderH])
      rotate([0,90,0])
        cylinder(d=radiatorD,h=radiatorL+2,center=true);
    for(y=[-1,1])
      translate([-(radiatorL/2-(lm8uuD)/2-wallThickness),y*25,0])
        cylinder(d=lm8uuD+3+0.2,h=2*lm8uuL,center=true);
    translate([0,0,1.75])
      #fan30mmScrewHoles();
    translate([0,0,10])
     holderMountScrewHoles();
  }

} 

hotendFanHolder();
