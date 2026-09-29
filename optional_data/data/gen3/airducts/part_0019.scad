$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 3 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 26.9;            // port flange half width
port_d = 53.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 21.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[3.012, -26.731], [-3.012, 26.731], [2.95, 27.403], [8.974, -26.059]]);
      translate([8.943, 1.008]) circle(r = 17);
    }
    hull() {
      translate([8.943, 1.008]) circle(r = 17);
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
      translate([36.992, 29.057]) circle(r = 17);
    }
    hull() {
      translate([36.992, 29.057]) circle(r = 17);
      polygon([[11.269, 41.012], [64.731, 34.988], [64.059, 29.026], [10.597, 35.05]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 38) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 14);
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
      translate([38.56, 42.969]) circle(r = 14);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([38, 38]) rotate([0, 0, 173.57]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
