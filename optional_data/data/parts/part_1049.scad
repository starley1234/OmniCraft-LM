// Recessed magnet cup.
$fn = 60;
eps = 0.02;
magnet_d = 8;
wall = 2;
outer_d = magnet_d+2*wall;
height = wall+4;
difference() {
    cylinder(d=outer_d,h=height);
    translate([0,0,wall-eps]) cylinder(d=magnet_d,h=height-wall+2*eps);
    translate([0,0,-eps]) cylinder(d=3.4,h=wall+2*eps);
}
