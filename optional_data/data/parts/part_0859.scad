// Conical spring washer.
$fn = 60;
eps = 0.02;
inner_d = 3.2;
outer_d = 8;
thickness = 1.2;
difference() {
    cylinder(d1=outer_d,d2=outer_d-2*thickness,h=thickness);
    translate([0,0,-eps]) cylinder(d=inner_d,h=thickness+2*eps);
}
