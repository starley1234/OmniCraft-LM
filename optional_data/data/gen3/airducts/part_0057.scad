$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 3 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 20.9;            // port flange half width
port_d = 41.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 16.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[2.34, -20.769], [-2.34, 20.769], [4.616, 21.552], [9.296, -19.985]]);
      translate([9.937, 1.12]) circle(r = 12);
    }
    hull() {
      translate([9.937, 1.12]) circle(r = 12);
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
      translate([36.88, 28.063]) circle(r = 12);
    }
    hull() {
      translate([36.88, 28.063]) circle(r = 12);
      polygon([[17.231, 40.34], [58.769, 35.66], [57.985, 28.704], [16.448, 33.384]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 20) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 9);
      translate([8.456, 0.953]) circle(r = 9);
    }
    hull() {
      translate([8.456, 0.953]) circle(r = 9);
      translate([16.488, 3.763]) circle(r = 9);
    }
    hull() {
      translate([16.488, 3.763]) circle(r = 9);
      translate([23.693, 8.29]) circle(r = 9);
    }
    hull() {
      translate([23.693, 8.29]) circle(r = 9);
      translate([29.71, 14.307]) circle(r = 9);
    }
    hull() {
      translate([29.71, 14.307]) circle(r = 9);
      translate([34.237, 21.512]) circle(r = 9);
    }
    hull() {
      translate([34.237, 21.512]) circle(r = 9);
      translate([37.047, 29.544]) circle(r = 9);
    }
    hull() {
      translate([37.047, 29.544]) circle(r = 9);
      translate([38.56, 42.969]) circle(r = 9);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
