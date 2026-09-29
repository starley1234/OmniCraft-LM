// Chamfered dowel pin.
$fn = 60;
eps = 0.02;
diameter = 16;
length = 50;
chamfer = 0.6;
union() {
    cylinder(d1 = diameter - 2 * chamfer, d2 = diameter, h = chamfer);
    translate([0, 0, chamfer]) cylinder(d = diameter, h = length - 2 * chamfer);
    translate([0, 0, length - chamfer]) cylinder(d1 = diameter, d2 = diameter - 2 * chamfer, h = chamfer);
}
