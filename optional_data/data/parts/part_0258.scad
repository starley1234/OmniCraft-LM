// Two-hole link plate.
$fn = 60;
eps = 0.02;
hole_d = 20;
length = 84;
width = 36;
thickness = 4;
difference() { hull() { translate([-length/2+width/2,0,0]) cylinder(d=width,h=thickness,center=true); translate([length/2-width/2,0,0]) cylinder(d=width,h=thickness,center=true); } for(x=[-length/2+width/2,length/2-width/2]) translate([x,0,-thickness/2-eps]) cylinder(d=hole_d,h=thickness+2*eps); }
