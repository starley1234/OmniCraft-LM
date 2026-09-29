$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 3.5 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 23.9;            // port flange half width
port_d = 47.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 18.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[2.676, -23.75], [-2.676, 23.75], [5.274, 24.645], [10.626, -22.854]]);
      translate([10.931, 1.232]) circle(r = 14);
    }
    hull() {
      translate([10.931, 1.232]) circle(r = 14);
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
      translate([52.768, 43.069]) circle(r = 14);
    }
    hull() {
      translate([52.768, 43.069]) circle(r = 14);
      polygon([[30.25, 56.676], [77.75, 51.324], [76.854, 43.374], [29.355, 48.726]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 31) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 10.5);
      translate([12.016, 1.354]) circle(r = 10.5);
    }
    hull() {
      translate([12.016, 1.354]) circle(r = 10.5);
      translate([23.43, 5.348]) circle(r = 10.5);
    }
    hull() {
      translate([23.43, 5.348]) circle(r = 10.5);
      translate([33.668, 11.781]) circle(r = 10.5);
    }
    hull() {
      translate([33.668, 11.781]) circle(r = 10.5);
      translate([42.219, 20.332]) circle(r = 10.5);
    }
    hull() {
      translate([42.219, 20.332]) circle(r = 10.5);
      translate([48.652, 30.57]) circle(r = 10.5);
    }
    hull() {
      translate([48.652, 30.57]) circle(r = 10.5);
      translate([52.646, 41.984]) circle(r = 10.5);
    }
    hull() {
      translate([52.646, 41.984]) circle(r = 10.5);
      translate([54.56, 58.969]) circle(r = 10.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
