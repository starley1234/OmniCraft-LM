// Square mounting washer.
$fn = 60;
eps = 0.02;
hole_d = 10.5;
side = 24;
thickness = 1.5;
difference() {
    cube([side,side,thickness],center=true);
    translate([0,0,-thickness/2-eps]) cylinder(d=hole_d,h=thickness+2*eps);
}
