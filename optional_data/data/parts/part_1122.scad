// Internal retaining ring.
$fn = 60;
eps = 0.02;
inner_d = 24;
outer_d = 30;
thickness = max(1.5, 1.5);
difference() { cylinder(d=outer_d,h=thickness); translate([0,0,-eps]) cylinder(d=inner_d,h=thickness+2*eps); translate([-outer_d/2-eps,-1,-eps]) cube([outer_d/2-inner_d/2+eps,2,thickness+2*eps]); }
