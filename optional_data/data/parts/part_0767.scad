// V-slot corner connector.
$fn = 60;
eps = 0.02;
profile = 50;
arm = 80;
plate_t = 5;
difference() {
    union() { cube([arm,profile,plate_t]); cube([profile,arm,plate_t]); }
    for (p=[[profile/2,arm-profile/2],[arm-profile/2,profile/2]]) translate([p[0],p[1],-eps]) cylinder(d=5.4,h=plate_t+2*eps);
}
