// Two-prong cotter pin.
$fn = 60;
eps = 0.02;
wire_d = 2;
length = 28;
prong_gap = wire_d*1.4;
union() {
    translate([-prong_gap/2,0,0]) cylinder(d=wire_d,h=length);
    translate([prong_gap/2,0,0]) cylinder(d=wire_d,h=length);
    translate([-prong_gap/2,0,length-wire_d/2]) rotate([0,90,0]) cylinder(d=wire_d,h=prong_gap);
}
