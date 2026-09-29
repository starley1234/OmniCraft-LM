$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 2.5 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 2.5;               // duct wall thickness
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
      translate([12.016, 1.354]) circle(r = 10);
    }
    hull() {
      translate([12.016, 1.354]) circle(r = 10);
      translate([23.43, 5.348]) circle(r = 10);
    }
    hull() {
      translate([23.43, 5.348]) circle(r = 10);
      translate([33.668, 11.781]) circle(r = 10);
    }
    hull() {
      translate([33.668, 11.781]) circle(r = 10);
      translate([42.219, 20.332]) circle(r = 10);
    }
    hull() {
      translate([42.219, 20.332]) circle(r = 10);
      translate([48.652, 30.57]) circle(r = 10);
    }
    hull() {
      translate([48.652, 30.57]) circle(r = 10);
      translate([52.646, 41.984]) circle(r = 10);
    }
    hull() {
      translate([52.646, 41.984]) circle(r = 10);
      translate([52.88, 44.063]) circle(r = 10);
    }
    hull() {
      translate([52.88, 44.063]) circle(r = 10);
      polygon([[35.219, 56.116], [72.781, 51.884], [71.997, 44.928], [34.435, 49.16]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 39) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 7.5);
      translate([12.016, 1.354]) circle(r = 7.5);
    }
    hull() {
      translate([12.016, 1.354]) circle(r = 7.5);
      translate([23.43, 5.348]) circle(r = 7.5);
    }
    hull() {
      translate([23.43, 5.348]) circle(r = 7.5);
      translate([33.668, 11.781]) circle(r = 7.5);
    }
    hull() {
      translate([33.668, 11.781]) circle(r = 7.5);
      translate([42.219, 20.332]) circle(r = 7.5);
    }
    hull() {
      translate([42.219, 20.332]) circle(r = 7.5);
      translate([48.652, 30.57]) circle(r = 7.5);
    }
    hull() {
      translate([48.652, 30.57]) circle(r = 7.5);
      translate([52.646, 41.984]) circle(r = 7.5);
    }
    hull() {
      translate([52.646, 41.984]) circle(r = 7.5);
      translate([54.56, 58.969]) circle(r = 7.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
