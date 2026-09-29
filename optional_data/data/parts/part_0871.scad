// Square mounting washer.
$fn = 60;
eps = 0.02;
hole_d = 5.3;
side = 14;
thickness = 1.2;
difference() {
    cube([side,side,thickness],center=true);
    translate([0,0,-thickness/2-eps]) cylinder(d=hole_d,h=thickness+2*eps);
}
