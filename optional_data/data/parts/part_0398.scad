// Low-profile button-head screw.
$fn = 60;
eps = 0.02;
shaft_d = 2.4;
head_d = 5;
head_h = 2.5;
shaft_l = 8;
socket_flat = head_d * 0.40;
difference() {
    union() {
        cylinder(d = shaft_d, h = shaft_l);
        translate([0, 0, shaft_l]) cylinder(d1 = shaft_d + 1.5, d2 = head_d, h = head_h * 0.45);
        translate([0, 0, shaft_l + head_h * 0.45]) cylinder(d1 = head_d, d2 = head_d * 0.82, h = head_h * 0.55);
    }
    translate([0, 0, shaft_l + head_h - head_h * 0.5 + eps])
        cylinder(d = socket_flat / cos(30), h = head_h * 0.5 + eps, $fn = 6);
}
