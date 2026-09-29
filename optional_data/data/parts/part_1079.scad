// Adjustable L bracket with upright slot.
$fn = 60;
eps = 0.02;
base_l = 50;
upright_h = 35;
width = 24;
thickness = 5;
slot_l = 12;
module vertical_slot() { hull() { translate([0,width/2,thickness+upright_h/2-slot_l/2]) rotate([90,0,0]) cylinder(d=5.4,h=width+2*eps); translate([0,width/2,thickness+upright_h/2+slot_l/2]) rotate([90,0,0]) cylinder(d=5.4,h=width+2*eps); } }
difference() {
    union() { cube([base_l,width,thickness]); cube([thickness,width,upright_h]); }
    for(x=[12,base_l-12]) translate([x,width/2,-eps]) cylinder(d=5.4,h=thickness+2*eps);
    vertical_slot();
}
