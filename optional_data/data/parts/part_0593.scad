// Knurled-style thumb knob with hex socket.
$fn = 60;
eps = 0.02;
thread_d = 8.4;
knob_d = 24;
knob_h = 14;
socket_flat = thread_d * 1.8;
difference() {
    union() {
        cylinder(d = knob_d, h = knob_h);
        for (i = [0 : 11]) rotate([0, 0, i * 30]) translate([knob_d / 2 - 1, 0, 0]) cylinder(d = 2.2, h = knob_h);
    }
    translate([0, 0, -eps]) cylinder(d = thread_d, h = knob_h + 2 * eps);
    translate([0, 0, knob_h - knob_h * 0.55]) cylinder(d = socket_flat / cos(30), h = knob_h * 0.55 + eps, $fn = 6);
}
