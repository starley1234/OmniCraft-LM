// Split clamp block.
$fn = 60;
eps = 0.02;
bore_d = 5;
body_w = 22;
body_h = 22;
body_l = 28;
slot_w = 2;
difference() {
    cube([body_l, body_w, body_h], center = true);
    translate([0, -body_w / 2 - eps, 0]) rotate([-90,0,0]) cylinder(d = bore_d, h = body_w + 2 * eps);
    translate([-slot_w / 2, -body_w / 2 - eps, 0]) cube([slot_w, body_w + 2 * eps, body_h / 2 + eps]);
    translate([-body_l / 2 - eps, 0, body_h / 2 - 5]) rotate([0,90,0]) cylinder(d = 4.2, h = body_l + 2 * eps);
}
