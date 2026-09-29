$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 3.5 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 20.9;            // port flange half width
port_d = 41.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 16.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[2.34, -20.769], [-2.34, 20.769], [5.61, 21.664], [10.29, -19.873]]);
      translate([10.931, 1.232]) circle(r = 12);
    }
    hull() {
      translate([10.931, 1.232]) circle(r = 12);
      translate([12.016, 1.354]) circle(r = 12);
    }
    hull() {
      translate([12.016, 1.354]) circle(r = 12);
      translate([23.43, 5.348]) circle(r = 12);
    }
    hull() {
      translate([23.43, 5.348]) circle(r = 12);
      translate([33.668, 11.781]) circle(r = 12);
    }
    hull() {
      translate([33.668, 11.781]) circle(r = 12);
      translate([42.219, 20.332]) circle(r = 12);
    }
    hull() {
      translate([42.219, 20.332]) circle(r = 12);
      translate([48.652, 30.57]) circle(r = 12);
    }
    hull() {
      translate([48.652, 30.57]) circle(r = 12);
      translate([52.646, 41.984]) circle(r = 12);
    }
    hull() {
      translate([52.646, 41.984]) circle(r = 12);
      translate([52.768, 43.069]) circle(r = 12);
    }
    hull() {
      translate([52.768, 43.069]) circle(r = 12);
      polygon([[33.231, 56.34], [74.769, 51.66], [73.873, 43.71], [32.336, 48.39]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 25) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 8.5);
      translate([12.016, 1.354]) circle(r = 8.5);
    }
    hull() {
      translate([12.016, 1.354]) circle(r = 8.5);
      translate([23.43, 5.348]) circle(r = 8.5);
    }
    hull() {
      translate([23.43, 5.348]) circle(r = 8.5);
      translate([33.668, 11.781]) circle(r = 8.5);
    }
    hull() {
      translate([33.668, 11.781]) circle(r = 8.5);
      translate([42.219, 20.332]) circle(r = 8.5);
    }
    hull() {
      translate([42.219, 20.332]) circle(r = 8.5);
      translate([48.652, 30.57]) circle(r = 8.5);
    }
    hull() {
      translate([48.652, 30.57]) circle(r = 8.5);
      translate([52.646, 41.984]) circle(r = 8.5);
    }
    hull() {
      translate([52.646, 41.984]) circle(r = 8.5);
      translate([54.56, 58.969]) circle(r = 8.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
}
