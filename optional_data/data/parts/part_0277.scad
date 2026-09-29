// Engraving-ready nameplate.
$fn = 60;
eps = 0.02;
length = 90;
width = 24;
thickness = 2;
difference() { cube([length,width,thickness],center=true); for(x=[-length/2+6,length/2-6]) translate([x,0,-thickness/2-eps]) cylinder(d=3.2,h=thickness+2*eps); }
