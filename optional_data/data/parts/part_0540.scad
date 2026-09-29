// Rod-end mounting plate.
$fn = 60;
eps = 0.02;
plate_l = 45;
plate_w = 24;
plate_t = 6;
bore_d = 5;
difference() {
    cube([plate_l, plate_w, plate_t], center = true);
    translate([0, 0, -plate_t / 2 - eps]) cylinder(d = bore_d, h = plate_t + 2 * eps);
    for (x = [-plate_l / 2 + 10, plate_l / 2 - 10])
        translate([x, 0, -plate_t / 2 - eps]) cylinder(d = 5.4, h = plate_t + 2 * eps);
}
