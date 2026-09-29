// Heat-set insert, simplified ribbed geometry.
$fn = 60;
eps = 0.02;
inner_d = 4.3;
outer_d = 6;
length = 6;
difference() {
    union() {
        cylinder(d=outer_d,h=length);
        for(z=[1.5:2:length-1]) translate([0,0,z]) cylinder(d=outer_d+1,h=0.7);
    }
    translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps);
}
