// Belt-guide pulley flange.
$fn = 60;
eps = 0.02;
bore_d = 6;
body_d = 20;
width = 10;
difference() { union() { cylinder(d=body_d,h=width); cylinder(d=body_d+6,h=1.5); translate([0,0,width-1.5]) cylinder(d=body_d+6,h=1.5); } translate([0,0,-eps]) cylinder(d=bore_d,h=width+2*eps); }
