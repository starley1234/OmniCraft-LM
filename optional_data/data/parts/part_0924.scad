// Carriage bolt with low dome.
$fn = 60;
eps = 0.02;
shaft_d = 14;
head_d = 30;
shaft_l = 40;
union() {
    cylinder(d=shaft_d,h=shaft_l);
    translate([0,0,shaft_l]) scale([1,1,0.55]) sphere(d=head_d);
    translate([-shaft_d/2,-shaft_d/2,shaft_l-1]) cube([shaft_d,shaft_d,2]);
}
