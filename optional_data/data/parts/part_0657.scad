// Axle spacer tube.
$fn = 60;
eps = 0.02;
inner_d = 3;
outer_d = 6;
length = 4;
difference() { cylinder(d = outer_d, h = length); translate([0,0,-eps]) cylinder(d = inner_d, h = length + 2 * eps); }
