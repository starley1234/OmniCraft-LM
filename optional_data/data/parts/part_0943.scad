// Clevis pin with cross-hole.
$fn = 60;
eps = 0.02;
pin_d = 12;
pin_l = 36;
head_d = pin_d + 5;
difference() {
    union() { cylinder(d=pin_d,h=pin_l); cylinder(d=head_d,h=2.5); }
    translate([0,-pin_d-eps,pin_l-3]) rotate([-90,0,0]) cylinder(d=pin_d*0.42,h=2*pin_d+2*eps);
}
