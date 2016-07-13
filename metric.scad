// nuts
// nutMxW - width of nut, nutMxH - height of nut
// M2
nutM2W = 4.0+0.3;
nutM2H = 1.9+0.2;
nutM2D = nutM2W/cos(30);
// M3
nutM3W = 5.4+0.3;
nutM3H = 2.3+0.2;
nutM3D = nutM3W/cos(30);

// screws
// M2
screwM2D = 2+0.3;
screwM2HeadD = 4.2;
screwM2HeadH = 2.0;
// M3
screwM3D = 3+0.3;
screwM3HeadD = 5.4+0.2;
screwM3HeadH = 3.0;

// lm8uu
lm8uuD = 15+0.4; // Diameter of lm8uu
lm8uuL = 24.1; // Length of lm8uu

// E3Dv5

//fan
fanT = 10; //fanThickness

screwM2 = [screwM2HeadD,screwM2HeadH,screwM2D];
module screw(size,L) {
  cylinder(d=size[0],h=size[1]);
    translate([0,0,size[1]])
      cylinder(d=size[3],h=L);
}

//screw(screwM2,3);
