// T-shaped mounting plate.
$fn = 60;
eps = 0.02;
stem_l = 140;
arm_l = 80;
width = 20;
thickness = 5;
difference() {
    union() { cube([stem_l,width,thickness],center=true); cube([width,arm_l,thickness],center=true); }
    for (p=[[-stem_l/2+10,0],[stem_l/2-10,0],[0,-arm_l/2+10],[0,arm_l/2-10]]) translate([p[0],p[1],-thickness/2-eps]) cylinder(d=5.4,h=thickness+2*eps);
}
