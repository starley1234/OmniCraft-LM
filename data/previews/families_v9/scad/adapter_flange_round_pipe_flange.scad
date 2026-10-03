$fn = 32;
// Round pipe flange with a 12 mm neck.

bore_d = 42;
outer_d = 70;
bolt_circle = 56;
bolt_n = 4;
bolt_d = 5.5;
flange_t = 8;
neck_l = 12;
neck_d = bore_d + 8;

difference() {
    union() {
        cylinder(h = flange_t, d = outer_d);
        translate([0, 0, flange_t]) cylinder(h = neck_l, d = neck_d);
    }
    translate([0, 0, -1]) cylinder(h = flange_t + neck_l + 2, d = bore_d);
    for (i = [0 : bolt_n - 1])
        rotate([0, 0, i * 360 / bolt_n])
            translate([bolt_circle / 2, 0, -1])
                cylinder(h = flange_t + 2, d = bolt_d);
}
