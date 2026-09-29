// Z-offset mounting bracket.
$fn = 60;
eps = 0.02;
length = 100;
height = 24;
width = 24;
thickness = 4;
difference() {
    union() {
        cube([length,width,thickness]);
        translate([0,0,height]) cube([length,width,thickness]);
        translate([0,0,thickness]) cube([thickness,width,height-thickness]);
    }
    for (x=[12,length-12]) {
        translate([x,width/2,-eps]) cylinder(d=5.4,h=thickness+2*eps);
        translate([x,width/2,height-eps]) cylinder(d=5.4,h=thickness+2*eps);
    }
}
