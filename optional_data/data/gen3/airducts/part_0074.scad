$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 4 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 25.9;            // port flange half width
port_d = 51.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 21.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[2.9, -25.737], [-2.9, 25.737], [4.056, 26.521], [9.856, -24.953]]);
      translate([9.937, 1.12]) circle(r = 17);
    }
    hull() {
      translate([9.937, 1.12]) circle(r = 17);
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
      translate([52.88, 44.063]) circle(r = 17);
    }
    hull() {
      translate([52.88, 44.063]) circle(r = 17);
      polygon([[28.263, 56.9], [79.737, 51.1], [78.953, 44.144], [27.479, 49.944]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 30) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 13);
      translate([12.016, 1.354]) circle(r = 13);
    }
    hull() {
      translate([12.016, 1.354]) circle(r = 13);
      translate([23.43, 5.348]) circle(r = 13);
    }
    hull() {
      translate([23.43, 5.348]) circle(r = 13);
      translate([33.668, 11.781]) circle(r = 13);
    }
    hull() {
      translate([33.668, 11.781]) circle(r = 13);
      translate([42.219, 20.332]) circle(r = 13);
    }
    hull() {
      translate([42.219, 20.332]) circle(r = 13);
      translate([48.652, 30.57]) circle(r = 13);
    }
    hull() {
      translate([48.652, 30.57]) circle(r = 13);
      translate([52.646, 41.984]) circle(r = 13);
    }
    hull() {
      translate([52.646, 41.984]) circle(r = 13);
      translate([54.56, 58.969]) circle(r = 13);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
