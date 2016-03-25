$fa=0.1;
$fs=0.1;

module fanHolderScrewLug(a=60,l1=10,l2=10,d=3) {
hull() {
difference() {
  cylinder(d=d,l1=10);
  translate([-(d)/2,-(d+1)/2,l1])
    rotate([0,a/2,0])
      #cube([d/cos(a/2)+1,d+1,l1]);
}

translate([-d/2,0,l1])
rotate([0,a,0])
translate([d/2,0,l2])
mirror([0,0,1])
  difference() {
    cylinder(d=d,h=l2);
    translate([-(d)/2,-(d+1)/2,l2])
      rotate([0,a/2,0])
        #cube([5/cos(a/2)+1,5+1,l2]);
}
}
}

fanHolderScrewLug(l1=8,l2=3);