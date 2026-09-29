// Threaded hand knob.
$fn = 60;
eps = 0.02;
thread_d = 17;
knob_d = 38;
knob_h = 20;
difference() {
    union() {
        cylinder(d=knob_d,h=knob_h);
        for(i=[0:15]) rotate([0,0,i*22.5]) translate([knob_d/2-1,0,0]) cylinder(d=2,h=knob_h);
    }
    translate([0,0,-eps]) cylinder(d=thread_d,h=knob_h+2*eps);
}
