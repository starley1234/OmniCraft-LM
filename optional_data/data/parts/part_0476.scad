// T-slot nut for aluminium extrusion.
$fn = 60;
eps = 0.02;
slot_w = 6;
thread_d = 5.4;
length = 14;
body_w = slot_w + 4;
body_h = 7;
difference() {
    union() {
        translate([-length / 2, -body_w / 2, 0]) cube([length, body_w, 3]);
        translate([-length / 2 + 3, -slot_w / 2, 3]) cube([length - 6, slot_w, body_h - 3]);
    }
    translate([0, 0, -eps]) cylinder(d = thread_d, h = body_h + 2 * eps);
}
