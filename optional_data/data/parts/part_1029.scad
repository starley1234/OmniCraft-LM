// Compact plate hinge.
$fn = 60;
eps = 0.02;
leaf_l = 24;
width = 24;
pin_d = 3;
leaf_t = 3;
difference() {
    union() {
        translate([-leaf_l,-width/2,0]) cube([leaf_l,width,leaf_t]);
        translate([0,-width/2,0]) cube([leaf_l,width,leaf_t]);
        translate([0,-width/2,leaf_t/2]) rotate([-90,0,0]) cylinder(d=pin_d+4,h=width);
    }
    translate([0,-width/2-eps,leaf_t/2]) rotate([-90,0,0]) cylinder(d=pin_d,h=width+2*eps);
}
