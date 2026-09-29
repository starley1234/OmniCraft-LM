// Press-fit end cap for 15 mm extrusion.
$fn = 60;
eps = 0.02;
profile = 15;
cap_t = 2.4;
wall = 2;
pin_d = profile - 2 * wall;
pin_l = 4;
union() {
    cube([profile + 1, profile + 1, cap_t], center = true);
    translate([0, 0, -cap_t / 2 - pin_l]) cylinder(d = pin_d, h = pin_l + eps);
}
