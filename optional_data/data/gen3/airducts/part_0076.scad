$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 4 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 20.9;            // port flange half width
port_d = 41.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 16.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[2.34, -20.769], [-2.34, 20.769], [5.61, 21.664], [10.29, -19.873]]);
      translate([10.931, 1.232]) circle(r = 12);
    }
    hull() {
      translate([10.931, 1.232]) circle(r = 12);
      translate([8.456, 0.953]) circle(r = 12);
    }
    hull() {
      translate([8.456, 0.953]) circle(r = 12);
      translate([16.488, 3.763]) circle(r = 12);
    }
    hull() {
      translate([16.488, 3.763]) circle(r = 12);
      translate([23.693, 8.29]) circle(r = 12);
    }
    hull() {
      translate([23.693, 8.29]) circle(r = 12);
      translate([29.71, 14.307]) circle(r = 12);
    }
    hull() {
      translate([29.71, 14.307]) circle(r = 12);
      translate([34.237, 21.512]) circle(r = 12);
    }
    hull() {
      translate([34.237, 21.512]) circle(r = 12);
      translate([37.047, 29.544]) circle(r = 12);
    }
    hull() {
      translate([37.047, 29.544]) circle(r = 12);
      translate([36.768, 27.069]) circle(r = 12);
    }
    hull() {
      translate([36.768, 27.069]) circle(r = 12);
      polygon([[17.231, 40.34], [58.769, 35.66], [57.873, 27.71], [16.336, 32.39]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 36) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 8);
      translate([8.456, 0.953]) circle(r = 8);
    }
    hull() {
      translate([8.456, 0.953]) circle(r = 8);
      translate([16.488, 3.763]) circle(r = 8);
    }
    hull() {
      translate([16.488, 3.763]) circle(r = 8);
      translate([23.693, 8.29]) circle(r = 8);
    }
    hull() {
      translate([23.693, 8.29]) circle(r = 8);
      translate([29.71, 14.307]) circle(r = 8);
    }
    hull() {
      translate([29.71, 14.307]) circle(r = 8);
      translate([34.237, 21.512]) circle(r = 8);
    }
    hull() {
      translate([34.237, 21.512]) circle(r = 8);
      translate([37.047, 29.544]) circle(r = 8);
    }
    hull() {
      translate([37.047, 29.544]) circle(r = 8);
      translate([38.56, 42.969]) circle(r = 8);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
}
