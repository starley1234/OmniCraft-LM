// Multi-hole mounting plate.
$fn = 60;
eps = 0.02;
plate_l = 110;
plate_w = 55;
plate_t = 6;
hole_d = 5.4;
edge = 10;
difference() {
    cube([plate_l, plate_w, plate_t], center = true);
    for (i = [0 : 4])
        translate([-plate_l / 2 + edge + i * (plate_l - 2 * edge) / max(1, 4), 0, -plate_t / 2 - eps])
            cylinder(d = hole_d, h = plate_t + 2 * eps);
}
