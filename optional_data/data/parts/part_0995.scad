// Hex spacer.
$fn = 60;
eps = 0.02;
inner_d = 17;
flat = 25;
length = 30;
difference() { cylinder(d=flat/cos(30),h=length,$fn=6); translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps); }
