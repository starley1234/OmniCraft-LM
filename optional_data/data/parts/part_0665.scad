// Axle spacer tube.
$fn = 60;
eps = 0.02;
inner_d = 16;
outer_d = 24;
length = 20;
difference() { cylinder(d = outer_d, h = length); translate([0,0,-eps]) cylinder(d = inner_d, h = length + 2 * eps); }
