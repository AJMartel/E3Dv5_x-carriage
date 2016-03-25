include <metric.scad>;


$fa=0.5;
$fs=0.5;

radiatorL=31.8; // Length of radiator
radiatorD=25; // Diameter of radiator
hotendNeckD=9;
fanHoleD = 28; //Diameter of fan hole

rodDst = 50; // Distance berween rods



//hotendFanHolderGap=0.1; // Distance between body & holder
centralGap=2; // Distance between two parts of body
wallThickness = 1.5;


// Spetial settings
carriageL=2*lm8uuL+wallThickness*2+centralGap;
hotendFanHolderH=radiatorD/2+5; // z size of hotend's fun holder WITHOUT gap
//hotendFanHolderH=carriageL/2-10; // z size of hotend's fun holder WITHOUT gap
hotendXtranslate=carriageL/2-hotendFanHolderH-10; // Radiator -> Fan distance = 5mm


nutM2 = [nutM2W,nutM2H,nutM2D];
nutM3 = [nutM3W,nutM3H,nutM3D];
fanScewL = 16;
fanHolderLugX=(radiatorL-nutM2D)/2;
fanHolderLugY=(50-lm8uuD)/2-nutM2W/2-wallThickness+0.5;
fanHolderLugDst=sqrt(pow(fanHolderLugX,2)+pow(fanHolderLugY,2)); // Distance from center of lug hole to center of fan hole
fanHolderLugAngle=atan(fanHolderLugY/fanHolderLugX); // I don't know how to describe this))

hh = 0;
//holderNutTranslate = sqrt(pow(lm8uuD/2+wallThickness,2)-pow((lm8uuD/2+wallThickness+hh)-nutM2W/2,2));
holderNutTranslate = sqrt(pow(lm8uuD/2,2)-pow((lm8uuD/2+hh)-nutM2W/2,2));
holderScrewTranslate = sqrt(pow(lm8uuD/2+wallThickness,2)-pow((lm8uuD/2+wallThickness+hh)-screwM2HeadD/2,2));
//holderScrewTranslate = sqrt(pow(lm8uuD/2,2)-pow((lm8uuD/2+hh)-screwM2HeadD/2,2));

gt2PlateL=15;
gt2PlateTh=2*wallThickness;