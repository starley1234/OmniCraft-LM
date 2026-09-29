// Hex spacer.
$fn = 60;
eps = 0.02;
inner_d = 10.5;
flat = 17;
length = 20;
difference() { cylinder(d=flat/cos(30),h=length,$fn=6); translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps); }
