$fn = 32;
// Крепёжная пластина 80x50x6 мм с 4 отверстиями по углам.
eps = 0.02;
plate_w = 80;
plate_l = 50;
plate_t = 6;
hole_d = 6;
hole_d = 6;
hole_d = 6;
hole_d = 6;
difference() {
    cube([plate_w, plate_l, plate_t], center = true);
    translate([0, 0, -plate_t / 2 - eps]) cylinder(d = 6, h = plate_t + 2 * eps);
    translate([0, 0, plate_t / 2 + eps]) cylinder(d = 6, h = plate_t + 2 * eps);
    translate([-plate_w / 2 - eps, 0, 0]) cylinder(d = 6, h = plate_w + 2 * eps);
    translate([plate_w / 2 - eps, 0, 0]) cylinder(d = 6, h = plate_w + 2 * eps);
}
