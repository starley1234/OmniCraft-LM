// Linear rail stop block.
$fn = 60;
eps = 0.02;
width = 22;
height = 24;
bore_d = 8;
length = 24;
difference() {
    cube([length,width,height],center=true);
    translate([0,-width/2-eps,0]) rotate([-90,0,0]) cylinder(d=bore_d,h=width+2*eps);
    for(x=[-7,7]) translate([x,0,-height/2-eps]) cylinder(d=4.3,h=height+2*eps);
}
