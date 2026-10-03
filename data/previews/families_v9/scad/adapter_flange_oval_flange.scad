$fn = 32;
// Oval two-bolt flange.

bore_d = 28;
pad_w = 52;
centres = 52;
bolt_d = 6.5;
flange_t = 5;
neck_l = 14;
neck_d = bore_d + 7;

difference() {
    union() {
        hull()
            for (x = [-centres / 2, centres / 2])
                translate([x, 0, 0]) cylinder(h = flange_t, d = pad_w);
        translate([0, 0, flange_t]) cylinder(h = neck_l, d = neck_d);
    }
    translate([0, 0, -1]) cylinder(h = flange_t + neck_l + 2, d = bore_d);
    for (x = [-centres / 2, centres / 2])
        translate([x, 0, -1]) cylinder(h = flange_t + 2, d = bolt_d);
}
