// Latch hook bracket.
$fn = 60;
eps = 0.02;
length = 50;
height = 18;
width = 16;
thickness = 4;
difference() { union() { cube([length,width,thickness]); translate([length-thickness,0,thickness]) cube([thickness,width,height]); } for(x=[10,length-10]) translate([x,width/2,-eps]) cylinder(d=4.3,h=thickness+2*eps); }
