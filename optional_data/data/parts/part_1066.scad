// PCB standoff with mounting base.
$fn = 60;
eps = 0.02;
thread_d = 6.4;
base_d = 16;
height = 30;
body_d = thread_d+5;
difference() {
    union() { cylinder(d=base_d,h=2); cylinder(d=body_d,h=height); }
    translate([0,0,-eps]) cylinder(d=thread_d,h=height+2*eps);
}
