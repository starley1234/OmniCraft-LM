// Pointer control knob.
$fn = 60;
eps = 0.02;
bore_d = 3;
knob_d = 12;
knob_h = 8;
difference() { union() { cylinder(d=knob_d,h=knob_h); translate([0,-1,knob_h]) cube([knob_d/2,2,1.5]); } translate([0,0,-eps]) cylinder(d=bore_d,h=knob_h+2*eps); }
