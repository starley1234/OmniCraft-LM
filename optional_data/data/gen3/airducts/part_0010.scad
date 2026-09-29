$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 3.5 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 22.9;            // port flange half width
port_d = 45.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 18.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[2.564, -22.756], [-2.564, 22.756], [4.392, 23.54], [9.52, -21.972]]);
      translate([9.937, 1.12]) circle(r = 14);
    }
    hull() {
      translate([9.937, 1.12]) circle(r = 14);
      translate([8.456, 0.953]) circle(r = 14);
    }
    hull() {
      translate([8.456, 0.953]) circle(r = 14);
      translate([16.488, 3.763]) circle(r = 14);
    }
    hull() {
      translate([16.488, 3.763]) circle(r = 14);
      translate([23.693, 8.29]) circle(r = 14);
    }
    hull() {
      translate([23.693, 8.29]) circle(r = 14);
      translate([29.71, 14.307]) circle(r = 14);
    }
    hull() {
      translate([29.71, 14.307]) circle(r = 14);
      translate([34.237, 21.512]) circle(r = 14);
    }
    hull() {
      translate([34.237, 21.512]) circle(r = 14);
      translate([37.047, 29.544]) circle(r = 14);
    }
    hull() {
      translate([37.047, 29.544]) circle(r = 14);
      translate([36.88, 28.063]) circle(r = 14);
    }
    hull() {
      translate([36.88, 28.063]) circle(r = 14);
      polygon([[15.244, 40.564], [60.756, 35.436], [59.972, 28.48], [14.46, 33.608]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 25) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 10.5);
      translate([8.456, 0.953]) circle(r = 10.5);
    }
    hull() {
      translate([8.456, 0.953]) circle(r = 10.5);
      translate([16.488, 3.763]) circle(r = 10.5);
    }
    hull() {
      translate([16.488, 3.763]) circle(r = 10.5);
      translate([23.693, 8.29]) circle(r = 10.5);
    }
    hull() {
      translate([23.693, 8.29]) circle(r = 10.5);
      translate([29.71, 14.307]) circle(r = 10.5);
    }
    hull() {
      translate([29.71, 14.307]) circle(r = 10.5);
      translate([34.237, 21.512]) circle(r = 10.5);
    }
    hull() {
      translate([34.237, 21.512]) circle(r = 10.5);
      translate([37.047, 29.544]) circle(r = 10.5);
    }
    hull() {
      translate([37.047, 29.544]) circle(r = 10.5);
      translate([38.56, 42.969]) circle(r = 10.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
