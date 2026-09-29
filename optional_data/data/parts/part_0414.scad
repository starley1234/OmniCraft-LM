// 2020 joining plate 100 mm: joining plate for T-slot aluminium profiles.
$fn = 60;
eps = 0.02;
plate_l = 100;
plate_w = 40;
plate_t = 5;
hole_d = 5.4;
counterbore_d = 9;
counterbore_h = 2.2;
edge = 10;

module mounting_hole(x, y) {
    translate([x, y, -plate_t / 2 - eps]) cylinder(d = hole_d, h = plate_t + 2 * eps);
    translate([x, y, plate_t / 2 - counterbore_h]) cylinder(d = counterbore_d, h = counterbore_h + eps);
}

difference() {
    cube([plate_l, plate_w, plate_t], center = true);
    for (x = [-plate_l / 2 + edge, plate_l / 2 - edge], y = [-plate_w / 2 + edge, plate_w / 2 - edge])
        mounting_hole(x, y);
}
