// Blind-rivet body.
$fn = 60;
eps = 0.02;
shank_d = 10;
head_d = 20;
length = 30;
difference() { union() { cylinder(d=shank_d+3,h=length); cylinder(d=max(head_d, shank_d+5),h=1.5); } translate([0,0,-eps]) cylinder(d=shank_d,h=length+2*eps); }
