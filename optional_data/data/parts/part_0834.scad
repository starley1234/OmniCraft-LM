// Limit-switch mounting plate.
$fn = 60;
eps = 0.02;
plate_l = 55;
plate_w = 26;
plate_t = 3;
slot_l = 16;
module slot(x) { hull() { translate([x-slot_l/2,0,-plate_t/2-eps]) cylinder(d=3.2,h=plate_t+2*eps); translate([x+slot_l/2,0,-plate_t/2-eps]) cylinder(d=3.2,h=plate_t+2*eps); } }
difference() { cube([plate_l,plate_w,plate_t],center=true); slot(-plate_l/4); slot(plate_l/4); }
