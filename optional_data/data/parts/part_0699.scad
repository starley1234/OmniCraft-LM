// Motor mounting standoff.
$fn = 60;
eps = 0.02;
thread_d = 3.4;
outer_d = 8;
length = 12;
difference() {
    union() { cylinder(d=outer_d,h=length); cylinder(d=outer_d+4,h=2); }
    translate([0,0,-eps]) cylinder(d=thread_d,h=length+2*eps);
}
