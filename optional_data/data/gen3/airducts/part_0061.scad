$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 2.5 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 23.9;            // port flange half width
port_d = 47.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 18.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[2.676, -23.75], [-2.676, 23.75], [4.28, 24.533], [9.632, -22.966]]);
      translate([9.937, 1.12]) circle(r = 14);
    }
    hull() {
      translate([9.937, 1.12]) circle(r = 14);
      translate([6.676, 0.752]) circle(r = 14);
    }
    hull() {
      translate([6.676, 0.752]) circle(r = 14);
      translate([13.017, 2.971]) circle(r = 14);
    }
    hull() {
      translate([13.017, 2.971]) circle(r = 14);
      translate([18.705, 6.545]) circle(r = 14);
    }
    hull() {
      translate([18.705, 6.545]) circle(r = 14);
      translate([23.455, 11.295]) circle(r = 14);
    }
    hull() {
      translate([23.455, 11.295]) circle(r = 14);
      translate([27.029, 16.983]) circle(r = 14);
    }
    hull() {
      translate([27.029, 16.983]) circle(r = 14);
      translate([29.248, 23.324]) circle(r = 14);
    }
    hull() {
      translate([29.248, 23.324]) circle(r = 14);
      translate([28.88, 20.063]) circle(r = 14);
    }
    hull() {
      translate([28.88, 20.063]) circle(r = 14);
      polygon([[6.25, 32.676], [53.75, 27.324], [52.966, 20.368], [5.467, 25.72]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 21) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 11.5);
      translate([6.676, 0.752]) circle(r = 11.5);
    }
    hull() {
      translate([6.676, 0.752]) circle(r = 11.5);
      translate([13.017, 2.971]) circle(r = 11.5);
    }
    hull() {
      translate([13.017, 2.971]) circle(r = 11.5);
      translate([18.705, 6.545]) circle(r = 11.5);
    }
    hull() {
      translate([18.705, 6.545]) circle(r = 11.5);
      translate([23.455, 11.295]) circle(r = 11.5);
    }
    hull() {
      translate([23.455, 11.295]) circle(r = 11.5);
      translate([27.029, 16.983]) circle(r = 11.5);
    }
    hull() {
      translate([27.029, 16.983]) circle(r = 11.5);
      translate([29.248, 23.324]) circle(r = 11.5);
    }
    hull() {
      translate([29.248, 23.324]) circle(r = 11.5);
      translate([30.56, 34.969]) circle(r = 11.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([30, 30]) rotate([0, 0, 173.57]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([30, 30]) rotate([0, 0, 173.57]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
}
