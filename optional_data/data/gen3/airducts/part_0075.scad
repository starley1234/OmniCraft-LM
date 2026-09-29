$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 3 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 18.9;            // port flange half width
port_d = 37.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 14.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[2.116, -18.781], [-2.116, 18.781], [4.84, 19.565], [9.072, -17.997]]);
      translate([9.937, 1.12]) circle(r = 10);
    }
    hull() {
      translate([9.937, 1.12]) circle(r = 10);
      translate([6.676, 0.752]) circle(r = 10);
    }
    hull() {
      translate([6.676, 0.752]) circle(r = 10);
      translate([13.017, 2.971]) circle(r = 10);
    }
    hull() {
      translate([13.017, 2.971]) circle(r = 10);
      translate([18.705, 6.545]) circle(r = 10);
    }
    hull() {
      translate([18.705, 6.545]) circle(r = 10);
      translate([23.455, 11.295]) circle(r = 10);
    }
    hull() {
      translate([23.455, 11.295]) circle(r = 10);
      translate([27.029, 16.983]) circle(r = 10);
    }
    hull() {
      translate([27.029, 16.983]) circle(r = 10);
      translate([29.248, 23.324]) circle(r = 10);
    }
    hull() {
      translate([29.248, 23.324]) circle(r = 10);
      translate([28.88, 20.063]) circle(r = 10);
    }
    hull() {
      translate([28.88, 20.063]) circle(r = 10);
      polygon([[11.219, 32.116], [48.781, 27.884], [47.997, 20.928], [10.435, 25.16]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 38) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 7);
      translate([6.676, 0.752]) circle(r = 7);
    }
    hull() {
      translate([6.676, 0.752]) circle(r = 7);
      translate([13.017, 2.971]) circle(r = 7);
    }
    hull() {
      translate([13.017, 2.971]) circle(r = 7);
      translate([18.705, 6.545]) circle(r = 7);
    }
    hull() {
      translate([18.705, 6.545]) circle(r = 7);
      translate([23.455, 11.295]) circle(r = 7);
    }
    hull() {
      translate([23.455, 11.295]) circle(r = 7);
      translate([27.029, 16.983]) circle(r = 7);
    }
    hull() {
      translate([27.029, 16.983]) circle(r = 7);
      translate([29.248, 23.324]) circle(r = 7);
    }
    hull() {
      translate([29.248, 23.324]) circle(r = 7);
      translate([30.56, 34.969]) circle(r = 7);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([30, 30]) rotate([0, 0, 173.57]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([30, 30]) rotate([0, 0, 173.57]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
