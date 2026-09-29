$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 3.5 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 18.9;            // port flange half width
port_d = 37.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 14.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[2.116, -18.781], [-2.116, 18.781], [5.834, 19.677], [10.066, -17.885]]);
      translate([10.931, 1.232]) circle(r = 10);
    }
    hull() {
      translate([10.931, 1.232]) circle(r = 10);
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
      translate([36.768, 27.069]) circle(r = 10);
    }
    hull() {
      translate([36.768, 27.069]) circle(r = 10);
      polygon([[19.219, 40.116], [56.781, 35.884], [55.885, 27.934], [18.323, 32.166]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 31) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 6.5);
      translate([8.456, 0.953]) circle(r = 6.5);
    }
    hull() {
      translate([8.456, 0.953]) circle(r = 6.5);
      translate([16.488, 3.763]) circle(r = 6.5);
    }
    hull() {
      translate([16.488, 3.763]) circle(r = 6.5);
      translate([23.693, 8.29]) circle(r = 6.5);
    }
    hull() {
      translate([23.693, 8.29]) circle(r = 6.5);
      translate([29.71, 14.307]) circle(r = 6.5);
    }
    hull() {
      translate([29.71, 14.307]) circle(r = 6.5);
      translate([34.237, 21.512]) circle(r = 6.5);
    }
    hull() {
      translate([34.237, 21.512]) circle(r = 6.5);
      translate([37.047, 29.544]) circle(r = 6.5);
    }
    hull() {
      translate([37.047, 29.544]) circle(r = 6.5);
      translate([38.56, 42.969]) circle(r = 6.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
}
