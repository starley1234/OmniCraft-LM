// Double-screw locking collar.
$fn = 60;
eps = 0.02;
shaft_d = 16;
outer_d = 32;
width = 16;
difference() {
    cylinder(d=outer_d,h=width);
    translate([0,0,-eps]) cylinder(d=shaft_d,h=width+2*eps);
    for (z=[width/3,2*width/3]) translate([-outer_d/2-eps,0,z]) rotate([0,90,0]) cylinder(d=3.4,h=outer_d/2+2*eps);
}
