// Multi-hole mounting plate.
$fn = 60;
eps = 0.02;
plate_l = 60;
plate_w = 30;
plate_t = 4;
hole_d = 5.4;
edge = 10;
difference() {
    cube([plate_l, plate_w, plate_t], center = true);
    for (i = [0 : 2])
        translate([-plate_l / 2 + edge + i * (plate_l - 2 * edge) / max(1, 2), 0, -plate_t / 2 - eps])
            cylinder(d = hole_d, h = plate_t + 2 * eps);
}
