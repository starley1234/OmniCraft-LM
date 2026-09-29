// Hex spacer.
$fn = 60;
eps = 0.02;
inner_d = 5.4;
flat = 10;
length = 10;
difference() { cylinder(d=flat/cos(30),h=length,$fn=6); translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps); }
