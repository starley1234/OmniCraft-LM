// Thumb screw, smooth-shank representation.
$fn = 60;
eps = 0.02;
shaft_d = 10.5;
head_d = 28;
shaft_l = 40;
head_h = 5;
difference() {
    union() { cylinder(d = shaft_d, h = shaft_l); translate([0, 0, shaft_l]) cylinder(d = head_d, h = head_h); }
    translate([0, 0, shaft_l + head_h - 3 + eps]) cylinder(d = head_d * 0.35 / cos(30), h = 3 + eps, $fn = 6);
}
