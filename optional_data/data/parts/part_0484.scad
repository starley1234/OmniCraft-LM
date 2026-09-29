// Multi-hole mounting plate.
$fn = 60;
eps = 0.02;
plate_l = 40;
plate_w = 20;
plate_t = 3;
hole_d = 5.4;
edge = 10;
difference() {
    cube([plate_l, plate_w, plate_t], center = true);
    for (i = [0 : 1])
        translate([-plate_l / 2 + edge + i * (plate_l - 2 * edge) / max(1, 1), 0, -plate_t / 2 - eps])
            cylinder(d = hole_d, h = plate_t + 2 * eps);
}
