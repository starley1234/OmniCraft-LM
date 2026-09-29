// Blind-rivet body.
$fn = 60;
eps = 0.02;
shank_d = 6.4;
head_d = 13;
length = 20;
difference() { union() { cylinder(d=shank_d+3,h=length); cylinder(d=max(head_d, shank_d+5),h=1.5); } translate([0,0,-eps]) cylinder(d=shank_d,h=length+2*eps); }
