// C-style pipe clamp.
$fn = 60;
eps = 0.02;
pipe_d = 10;
wall = 2;
outer_d = pipe_d+2*wall;
width = 12;
difference() {
    cylinder(d=outer_d,h=width);
    translate([0,0,-eps]) cylinder(d=pipe_d,h=width+2*eps);
    translate([0,-1,-eps]) cube([outer_d/2+eps,2,width+2*eps]);
    translate([outer_d/2-3,-outer_d/2-eps,width/2]) rotate([-90,0,0]) cylinder(d=4.2,h=outer_d+2*eps);
}
