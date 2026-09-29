$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 4 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 25.9;            // port flange half width
port_d = 51.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 21.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[2.9, -25.737], [-2.9, 25.737], [4.056, 26.521], [9.856, -24.953]]);
      translate([9.937, 1.12]) circle(r = 17);
    }
    hull() {
      translate([9.937, 1.12]) circle(r = 17);
      translate([8.456, 0.953]) circle(r = 17);
    }
    hull() {
      translate([8.456, 0.953]) circle(r = 17);
      translate([16.488, 3.763]) circle(r = 17);
    }
    hull() {
      translate([16.488, 3.763]) circle(r = 17);
      translate([23.693, 8.29]) circle(r = 17);
    }
    hull() {
      translate([23.693, 8.29]) circle(r = 17);
      translate([29.71, 14.307]) circle(r = 17);
    }
    hull() {
      translate([29.71, 14.307]) circle(r = 17);
      translate([34.237, 21.512]) circle(r = 17);
    }
    hull() {
      translate([34.237, 21.512]) circle(r = 17);
      translate([37.047, 29.544]) circle(r = 17);
    }
    hull() {
      translate([37.047, 29.544]) circle(r = 17);
      translate([36.88, 28.063]) circle(r = 17);
    }
    hull() {
      translate([36.88, 28.063]) circle(r = 17);
      polygon([[12.263, 40.9], [63.737, 35.1], [62.953, 28.144], [11.479, 33.944]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 24) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 13);
      translate([8.456, 0.953]) circle(r = 13);
    }
    hull() {
      translate([8.456, 0.953]) circle(r = 13);
      translate([16.488, 3.763]) circle(r = 13);
    }
    hull() {
      translate([16.488, 3.763]) circle(r = 13);
      translate([23.693, 8.29]) circle(r = 13);
    }
    hull() {
      translate([23.693, 8.29]) circle(r = 13);
      translate([29.71, 14.307]) circle(r = 13);
    }
    hull() {
      translate([29.71, 14.307]) circle(r = 13);
      translate([34.237, 21.512]) circle(r = 13);
    }
    hull() {
      translate([34.237, 21.512]) circle(r = 13);
      translate([37.047, 29.544]) circle(r = 13);
    }
    hull() {
      translate([37.047, 29.544]) circle(r = 13);
      translate([38.56, 42.969]) circle(r = 13);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
