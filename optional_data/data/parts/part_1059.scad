// PCB standoff with mounting base.
$fn = 60;
eps = 0.02;
thread_d = 3.4;
base_d = 10;
height = 6;
body_d = thread_d+5;
difference() {
    union() { cylinder(d=base_d,h=2); cylinder(d=body_d,h=height); }
    translate([0,0,-eps]) cylinder(d=thread_d,h=height+2*eps);
}
