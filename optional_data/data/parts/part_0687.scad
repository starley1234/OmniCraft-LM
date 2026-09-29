// Slotted mounting plate.
$fn = 60;
eps = 0.02;
plate_l = 40;
plate_w = 20;
plate_t = 4;
slot_l = 12;
slot_d = 5.4;
module slot(x) { hull() { translate([x-slot_l/2,0,-plate_t/2-eps]) cylinder(d=slot_d,h=plate_t+2*eps); translate([x+slot_l/2,0,-plate_t/2-eps]) cylinder(d=slot_d,h=plate_t+2*eps); } }
difference() { cube([plate_l, plate_w, plate_t], center=true); for (i=[0:1]) slot(-plate_l/2+14+i*(plate_l-28)/max(1,1)); }
