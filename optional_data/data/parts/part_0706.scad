// Motor mounting standoff.
$fn = 60;
eps = 0.02;
thread_d = 10.5;
outer_d = 22;
length = 32;
difference() {
    union() { cylinder(d=outer_d,h=length); cylinder(d=outer_d+4,h=2); }
    translate([0,0,-eps]) cylinder(d=thread_d,h=length+2*eps);
}
