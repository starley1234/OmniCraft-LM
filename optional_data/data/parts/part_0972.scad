// Flanged threaded insert.
$fn = 60;
eps = 0.02;
inner_d = 8.4;
outer_d = 15;
length = 14;
flange_d = 22;
difference() {
    union() { cylinder(d=outer_d,h=length); cylinder(d=flange_d,h=2); }
    translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps);
}
