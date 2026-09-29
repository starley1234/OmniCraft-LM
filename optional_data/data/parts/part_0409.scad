// Countersunk screw with 90-degree conical head.
$fn = 60;
eps = 0.02;
shaft_d = 2.4;
head_d = 5;
head_h = 1.5;
shaft_l = 8;
union() {
    cylinder(d = shaft_d, h = shaft_l);
    translate([0, 0, shaft_l]) cylinder(d1 = shaft_d, d2 = head_d, h = head_h);
}
