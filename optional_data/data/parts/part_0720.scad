// Snap panel clip with a U-shaped panel slot.
$fn = 60;
eps = 0.02;
panel_t = 1.5;
clip_w = 14;
clip_l = 28;
clip_h = panel_t + 8;
slot = panel_t + 0.5;
difference() {
    cube([clip_l,clip_w,clip_h],center=true);
    translate([2,0,clip_h/2-slot/2]) cube([clip_l/2+eps,clip_w+2*eps,slot+eps],center=true);
    translate([-clip_l/2-eps,0,-clip_h/2]) rotate([0,90,0]) cylinder(d=4.3,h=clip_l/2+2*eps);
}
