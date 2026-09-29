// T-head slot bolt.
$fn = 60;
eps = 0.02;
shaft_d = 16;
head_l = 38;
shaft_l = 32;
head_w = shaft_d + 5;
head_h = 3;
union() {
    translate([-head_l/2,-head_w/2,0]) cube([head_l,head_w,head_h]);
    translate([0,0,head_h]) cylinder(d=shaft_d,h=shaft_l);
}
