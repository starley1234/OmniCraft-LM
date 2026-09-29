// Flanged threaded insert.
$fn = 60;
eps = 0.02;
inner_d = 13;
outer_d = 22;
length = 18;
flange_d = 30;
difference() {
    union() { cylinder(d=outer_d,h=length); cylinder(d=flange_d,h=2); }
    translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps);
}
