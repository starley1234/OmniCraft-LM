// Hex spacer.
$fn = 60;
eps = 0.02;
inner_d = 6.4;
flat = 12;
length = 12;
difference() { cylinder(d=flat/cos(30),h=length,$fn=6); translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps); }
