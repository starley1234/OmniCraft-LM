// Gear blank with external locator teeth.
$fn = 60;
eps = 0.02;
bore_d = 10;
root_d = 32;
teeth = 24;
thickness = 6;
difference() { union() { cylinder(d=root_d,h=thickness); for(i=[0:teeth-1]) rotate([0,0,i*360/teeth]) translate([root_d/2,0,0]) cube([2,max(2,root_d*0.08),thickness],center=true); } translate([0,0,-eps]) cylinder(d=bore_d,h=thickness+2*eps); }
