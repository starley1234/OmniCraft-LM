// Socket-head cap screw, smooth printable representation.
$fn = 60;
eps = 0.02;
shaft_d = 8.4;
head_d = 13;
head_h = 8;
shaft_l = 30;
socket_flat = head_d * 0.46;
socket_depth = head_h * 0.55;
difference() {
    union() {
        cylinder(d = shaft_d, h = shaft_l);
        translate([0, 0, shaft_l]) cylinder(d = head_d, h = head_h);
    }
    translate([0, 0, shaft_l + head_h - socket_depth + eps])
        cylinder(d = socket_flat / cos(30), h = socket_depth + eps, $fn = 6);
}
