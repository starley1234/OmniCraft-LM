// External-serrated lock washer.
$fn = 60;
eps = 0.02;
inner_d = 6.4;
outer_d = 14;
thickness = 1.2;
teeth = 16;
difference() {
    union() {
        cylinder(d=outer_d-1.2,h=thickness);
        for(i=[0:teeth-1]) rotate([0,0,i*360/teeth]) translate([outer_d/2-0.8,0,0]) cylinder(d=2.2,h=thickness);
    }
    translate([0,0,-eps]) cylinder(d=inner_d,h=thickness+2*eps);
}
