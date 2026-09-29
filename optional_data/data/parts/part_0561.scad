// Adjustable leveling foot, smooth threaded-shaft representation.
$fn = 60;
eps = 0.02;
shaft_d = 6;
pad_d = 24;
shaft_l = 16;
pad_h = 7;
union() {
    cylinder(d = pad_d, h = pad_h);
    translate([0, 0, pad_h]) cylinder(d1 = pad_d * 0.55, d2 = shaft_d + 4, h = 4);
    translate([0, 0, pad_h + 4]) cylinder(d = shaft_d, h = shaft_l);
}
