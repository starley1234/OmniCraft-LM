// Flanged sleeve bushing.
$fn = 60;
eps = 0.02;
inner_d = 8;
outer_d = 14;
length = 16;
flange_d = 24;
flange_t = 2.5;
difference() {
    union() {
        cylinder(d = flange_d, h = flange_t);
        cylinder(d = outer_d, h = length);
    }
    translate([0, 0, -eps]) cylinder(d = inner_d, h = length + 2 * eps);
}
