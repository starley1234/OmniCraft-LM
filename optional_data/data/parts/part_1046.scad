// Latch catch plate.
$fn = 60;
eps = 0.02;
length = 90;
height = 32;
width = 22;
thickness = 4;
difference() {
    union() { cube([length,width,thickness]); translate([length-6,0,thickness]) cube([6,width,height]); }
    for(x=[10,length-14]) translate([x,width/2,-eps]) cylinder(d=4.3,h=thickness+2*eps);
}
