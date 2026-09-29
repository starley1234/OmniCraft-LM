// Cable-tie base with two strap slots.
$fn = 60;
eps = 0.02;
base_w = 14;
base_l = 22;
base_t = 4;
slot_w = 3;
slot_l = 12;
difference() {
    cube([base_l,base_w,base_t],center=true);
    for (x=[-slot_l/2,slot_l/2]) translate([x,0,-base_t/2-eps]) cube([slot_w,base_w*0.55,base_t+2*eps],center=true);
    for (x=[-base_l/2+7,base_l/2-7]) translate([x,0,-base_t/2-eps]) cylinder(d=3.4,h=base_t+2*eps);
}
