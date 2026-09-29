// Countersunk screw with 90-degree conical head.
$fn = 60;
eps = 0.02;
shaft_d = 5.4;
head_d = 10;
head_h = 2.8;
shaft_l = 16;
union() {
    cylinder(d = shaft_d, h = shaft_l);
    translate([0, 0, shaft_l]) cylinder(d1 = shaft_d, d2 = head_d, h = head_h);
}
