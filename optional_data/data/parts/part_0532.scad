// Flange bearing block for 26 mm bearing OD.
$fn = 60;
eps = 0.02;
bearing_d = 26;
plate_l = bearing_d + 34;
plate_t = 7;
hub_h = bearing_d / 2 + 4;
difference() {
    union() {
        cube([plate_l, plate_l, plate_t], center = true);
        cylinder(d = bearing_d + 8, h = hub_h);
    }
    translate([0, 0, -eps]) cylinder(d = bearing_d, h = hub_h + 2 * eps);
    for (x = [-plate_l / 3, plate_l / 3], y = [-plate_l / 3, plate_l / 3])
        translate([x, y, -plate_t / 2 - eps]) cylinder(d = 4.3, h = plate_t + 2 * eps);
}
