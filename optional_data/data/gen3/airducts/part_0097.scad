$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 3 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 25.9;            // port flange half width
port_d = 51.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 21.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[2.9, -25.737], [-2.9, 25.737], [5.05, 26.633], [10.85, -24.841]]);
      translate([10.931, 1.232]) circle(r = 17);
    }
    hull() {
      translate([10.931, 1.232]) circle(r = 17);
      translate([12.016, 1.354]) circle(r = 17);
    }
    hull() {
      translate([12.016, 1.354]) circle(r = 17);
      translate([23.43, 5.348]) circle(r = 17);
    }
    hull() {
      translate([23.43, 5.348]) circle(r = 17);
      translate([33.668, 11.781]) circle(r = 17);
    }
    hull() {
      translate([33.668, 11.781]) circle(r = 17);
      translate([42.219, 20.332]) circle(r = 17);
    }
    hull() {
      translate([42.219, 20.332]) circle(r = 17);
      translate([48.652, 30.57]) circle(r = 17);
    }
    hull() {
      translate([48.652, 30.57]) circle(r = 17);
      translate([52.646, 41.984]) circle(r = 17);
    }
    hull() {
      translate([52.646, 41.984]) circle(r = 17);
      translate([52.768, 43.069]) circle(r = 17);
    }
    hull() {
      translate([52.768, 43.069]) circle(r = 17);
      polygon([[28.263, 56.9], [79.737, 51.1], [78.841, 43.15], [27.367, 48.95]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 26) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 14);
      translate([12.016, 1.354]) circle(r = 14);
    }
    hull() {
      translate([12.016, 1.354]) circle(r = 14);
      translate([23.43, 5.348]) circle(r = 14);
    }
    hull() {
      translate([23.43, 5.348]) circle(r = 14);
      translate([33.668, 11.781]) circle(r = 14);
    }
    hull() {
      translate([33.668, 11.781]) circle(r = 14);
      translate([42.219, 20.332]) circle(r = 14);
    }
    hull() {
      translate([42.219, 20.332]) circle(r = 14);
      translate([48.652, 30.57]) circle(r = 14);
    }
    hull() {
      translate([48.652, 30.57]) circle(r = 14);
      translate([52.646, 41.984]) circle(r = 14);
    }
    hull() {
      translate([52.646, 41.984]) circle(r = 14);
      translate([54.56, 58.969]) circle(r = 14);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
}
