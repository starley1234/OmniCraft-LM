$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 3 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 19.9;            // port flange half width
port_d = 39.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 14.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[2.228, -19.775], [-2.228, 19.775], [4.728, 20.559], [9.184, -18.991]]);
      translate([9.937, 1.12]) circle(r = 10);
    }
    hull() {
      translate([9.937, 1.12]) circle(r = 10);
      translate([8.456, 0.953]) circle(r = 10);
    }
    hull() {
      translate([8.456, 0.953]) circle(r = 10);
      translate([16.488, 3.763]) circle(r = 10);
    }
    hull() {
      translate([16.488, 3.763]) circle(r = 10);
      translate([23.693, 8.29]) circle(r = 10);
    }
    hull() {
      translate([23.693, 8.29]) circle(r = 10);
      translate([29.71, 14.307]) circle(r = 10);
    }
    hull() {
      translate([29.71, 14.307]) circle(r = 10);
      translate([34.237, 21.512]) circle(r = 10);
    }
    hull() {
      translate([34.237, 21.512]) circle(r = 10);
      translate([37.047, 29.544]) circle(r = 10);
    }
    hull() {
      translate([37.047, 29.544]) circle(r = 10);
      translate([36.88, 28.063]) circle(r = 10);
    }
    hull() {
      translate([36.88, 28.063]) circle(r = 10);
      polygon([[18.225, 40.228], [57.775, 35.772], [56.991, 28.816], [17.441, 33.272]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 32) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 7);
      translate([8.456, 0.953]) circle(r = 7);
    }
    hull() {
      translate([8.456, 0.953]) circle(r = 7);
      translate([16.488, 3.763]) circle(r = 7);
    }
    hull() {
      translate([16.488, 3.763]) circle(r = 7);
      translate([23.693, 8.29]) circle(r = 7);
    }
    hull() {
      translate([23.693, 8.29]) circle(r = 7);
      translate([29.71, 14.307]) circle(r = 7);
    }
    hull() {
      translate([29.71, 14.307]) circle(r = 7);
      translate([34.237, 21.512]) circle(r = 7);
    }
    hull() {
      translate([34.237, 21.512]) circle(r = 7);
      translate([37.047, 29.544]) circle(r = 7);
    }
    hull() {
      translate([37.047, 29.544]) circle(r = 7);
      translate([38.56, 42.969]) circle(r = 7);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
}
