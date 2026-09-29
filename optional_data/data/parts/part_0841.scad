// Split lock washer.
$fn = 60;
eps = 0.02;
inner_d = 3.2;
outer_d = 8;
thickness = 1;
gap = 1.5;
difference() {
    cylinder(d=outer_d,h=thickness);
    translate([0,0,-eps]) cylinder(d=inner_d,h=thickness+2*eps);
    translate([outer_d/2-gap/2,-gap/2,-eps]) cube([gap+eps,gap,thickness+2*eps]);
}
