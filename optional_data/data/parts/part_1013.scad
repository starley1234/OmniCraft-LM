// Plain idler pulley with retaining flanges.
$fn = 60;
eps = 0.02;
bore_d = 10;
body_d = 28;
width = 14;
flange_t = 1.5;
difference() {
    union() {
        cylinder(d=body_d,h=width);
        cylinder(d=body_d+4,h=flange_t);
        translate([0,0,width-flange_t]) cylinder(d=body_d+4,h=flange_t);
    }
    translate([0,0,-eps]) cylinder(d=bore_d,h=width+2*eps);
}
