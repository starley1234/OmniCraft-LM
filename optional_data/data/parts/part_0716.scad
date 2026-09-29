// Saddle clamp base for round tube.
$fn = 60;
eps = 0.02;
pipe_d = 6;
base_l = 44;
base_w = 20;
base_t = 6;
difference() {
    cube([base_l,base_w,base_t],center=true);
    translate([0,-base_w/2-eps,base_t/2]) rotate([-90,0,0]) cylinder(d=pipe_d,h=base_w+2*eps);
    for (x=[-base_l/2+10,base_l/2-10]) translate([x,0,-base_t/2-eps]) cylinder(d=5.4,h=base_t+2*eps);
}
