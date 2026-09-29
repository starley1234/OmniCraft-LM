// Countersunk screw with 90-degree conical head.
$fn = 60;
eps = 0.02;
shaft_d = 10.5;
head_d = 20;
head_h = 5;
shaft_l = 40;
union() {
    cylinder(d = shaft_d, h = shaft_l);
    translate([0, 0, shaft_l]) cylinder(d1 = shaft_d, d2 = head_d, h = head_h);
}
