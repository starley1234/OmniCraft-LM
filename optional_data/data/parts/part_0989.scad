// Hex spacer.
$fn = 60;
eps = 0.02;
inner_d = 4.3;
flat = 8;
length = 8;
difference() { cylinder(d=flat/cos(30),h=length,$fn=6); translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps); }
