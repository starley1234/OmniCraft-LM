// Adjustable sensor mounting tab.
$fn = 60;
eps = 0.02;
length = 50;
width = 22;
thickness = 4;
slot_l = 14;
module slot(x) { hull() { translate([x-slot_l/2,0,-thickness/2-eps]) cylinder(d=3.4,h=thickness+2*eps); translate([x+slot_l/2,0,-thickness/2-eps]) cylinder(d=3.4,h=thickness+2*eps); } }
difference() { cube([length,width,thickness],center=true); slot(-length/4); translate([length/4,0,-thickness/2-eps]) cylinder(d=3.4,h=thickness+2*eps); }
