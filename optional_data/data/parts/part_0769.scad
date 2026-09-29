// Triangular reinforcement gusset.
$fn = 60;
eps = 0.02;
leg = 20;
thickness = 3;
difference() {
    linear_extrude(height=thickness) polygon(points=[[0,0],[leg,0],[0,leg]]);
    translate([leg*0.25,leg*0.25,-eps]) cylinder(d=5.4,h=thickness+2*eps);
}
