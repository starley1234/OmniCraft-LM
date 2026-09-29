// Slotted roll pin.
$fn = 60;
eps = 0.02;
inner_d = 1.5;
outer_d = 3;
length = 10;
slot = 1.4;
difference() {
    cylinder(d=outer_d,h=length);
    translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps);
    translate([0,-slot/2,-eps]) cube([outer_d/2+eps,slot,length+2*eps]);
}
