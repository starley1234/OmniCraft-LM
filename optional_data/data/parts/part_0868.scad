// Conical spring washer.
$fn = 60;
eps = 0.02;
inner_d = 26;
outer_d = 48;
thickness = 3;
difference() {
    cylinder(d1=outer_d,d2=outer_d-2*thickness,h=thickness);
    translate([0,0,-eps]) cylinder(d=inner_d,h=thickness+2*eps);
}
