// Flanged sleeve bushing.
$fn = 60;
eps = 0.02;
inner_d = 5;
outer_d = 10;
length = 12;
flange_d = 18;
flange_t = 2.5;
difference() {
    union() {
        cylinder(d = flange_d, h = flange_t);
        cylinder(d = outer_d, h = length);
    }
    translate([0, 0, -eps]) cylinder(d = inner_d, h = length + 2 * eps);
}
