// Linear rail spacer strip.
$fn = 60;
eps = 0.02;
length = 200;
width = 32;
thickness = 8;
hole_pitch = 20;
difference() {
    cube([length,width,thickness],center=true);
    for (x=[-length/2+10:hole_pitch:length/2-10]) translate([x,0,-thickness/2-eps]) cylinder(d=4.3,h=thickness+2*eps);
}
