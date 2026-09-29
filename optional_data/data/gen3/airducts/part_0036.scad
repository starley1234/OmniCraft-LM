$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 3.5 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 21.9;            // port flange half width
port_d = 43.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 16.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[2.452, -21.762], [-2.452, 21.762], [3.51, 22.434], [8.414, -21.091]]);
      translate([8.943, 1.008]) circle(r = 12);
    }
    hull() {
      translate([8.943, 1.008]) circle(r = 12);
      translate([6.676, 0.752]) circle(r = 12);
    }
    hull() {
      translate([6.676, 0.752]) circle(r = 12);
      translate([13.017, 2.971]) circle(r = 12);
    }
    hull() {
      translate([13.017, 2.971]) circle(r = 12);
      translate([18.705, 6.545]) circle(r = 12);
    }
    hull() {
      translate([18.705, 6.545]) circle(r = 12);
      translate([23.455, 11.295]) circle(r = 12);
    }
    hull() {
      translate([23.455, 11.295]) circle(r = 12);
      translate([27.029, 16.983]) circle(r = 12);
    }
    hull() {
      translate([27.029, 16.983]) circle(r = 12);
      translate([29.248, 23.324]) circle(r = 12);
    }
    hull() {
      translate([29.248, 23.324]) circle(r = 12);
      translate([28.992, 21.057]) circle(r = 12);
    }
    hull() {
      translate([28.992, 21.057]) circle(r = 12);
      polygon([[8.238, 32.452], [51.762, 27.548], [51.091, 21.586], [7.566, 26.49]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 37) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 8.5);
      translate([6.676, 0.752]) circle(r = 8.5);
    }
    hull() {
      translate([6.676, 0.752]) circle(r = 8.5);
      translate([13.017, 2.971]) circle(r = 8.5);
    }
    hull() {
      translate([13.017, 2.971]) circle(r = 8.5);
      translate([18.705, 6.545]) circle(r = 8.5);
    }
    hull() {
      translate([18.705, 6.545]) circle(r = 8.5);
      translate([23.455, 11.295]) circle(r = 8.5);
    }
    hull() {
      translate([23.455, 11.295]) circle(r = 8.5);
      translate([27.029, 16.983]) circle(r = 8.5);
    }
    hull() {
      translate([27.029, 16.983]) circle(r = 8.5);
      translate([29.248, 23.324]) circle(r = 8.5);
    }
    hull() {
      translate([29.248, 23.324]) circle(r = 8.5);
      translate([30.56, 34.969]) circle(r = 8.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([30, 30]) rotate([0, 0, 173.57]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([30, 30]) rotate([0, 0, 173.57]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
