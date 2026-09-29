// V-groove guide wheel.
$fn = 60;
eps = 0.02;
bore_d = 4;
outer_d = 18;
width = 9;
groove_d = outer_d-6;
difference() {
    union() { cylinder(d=outer_d,h=width/2); translate([0,0,width/2]) cylinder(d1=outer_d,d2=groove_d,h=width/4); translate([0,0,3*width/4]) cylinder(d1=groove_d,d2=outer_d,h=width/4); }
    translate([0,0,-eps]) cylinder(d=bore_d,h=width+2*eps);
}
