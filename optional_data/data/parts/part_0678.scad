// Single-hole mounting tab.
$fn = 60;
eps = 0.02;
tab_w = 14;
tab_h = 24;
tab_t = 3;
hole_d = 5.4;
difference() {
    hull() {
        translate([0, 0, 0]) cube([tab_w, tab_w, tab_t], center = true);
        translate([0, tab_h / 2 - tab_w / 2, 0]) cylinder(d = tab_w, h = tab_t, center = true);
    }
    translate([0, tab_h / 2 - tab_w / 2, -tab_t / 2 - eps]) cylinder(d = hole_d, h = tab_t + 2 * eps);
}
