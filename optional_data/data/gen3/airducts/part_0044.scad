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
      polygon([[4.498, -4.077], [-36.498, 4.077], [-34.938, 11.924], [6.059, 3.769]]);
      translate([-13.854, 10.789]) circle(r = 12);
    }
    hull() {
      translate([-13.854, 10.789]) circle(r = 12);
      translate([-12.498, 17.603]) circle(r = 12);
    }
    hull() {
      translate([-12.498, 17.603]) circle(r = 12);
      translate([-2.527, 32.527]) circle(r = 12);
    }
    hull() {
      translate([-2.527, 32.527]) circle(r = 12);
      translate([12.397, 42.498]) circle(r = 12);
    }
    hull() {
      translate([12.397, 42.498]) circle(r = 12);
      translate([30, 46]) circle(r = 12);
    }
    hull() {
      translate([30, 46]) circle(r = 12);
      translate([93.603, 49.502]) circle(r = 12);
    }
    hull() {
      translate([93.603, 49.502]) circle(r = 12);
      translate([108.527, 59.473]) circle(r = 12);
    }
    hull() {
      translate([108.527, 59.473]) circle(r = 12);
      translate([118.498, 74.397]) circle(r = 12);
    }
    hull() {
      translate([118.498, 74.397]) circle(r = 12);
      translate([119.854, 81.211]) circle(r = 12);
    }
    hull() {
      translate([119.854, 81.211]) circle(r = 12);
      polygon([[101.502, 96.077], [142.498, 87.923], [140.938, 80.076], [99.941, 88.231]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 25) {
    hull() {
      translate([-16.975, -4.904]) circle(r = 8.5);
      translate([-12.498, 17.603]) circle(r = 8.5);
    }
    hull() {
      translate([-12.498, 17.603]) circle(r = 8.5);
      translate([-2.527, 32.527]) circle(r = 8.5);
    }
    hull() {
      translate([-2.527, 32.527]) circle(r = 8.5);
      translate([12.397, 42.498]) circle(r = 8.5);
    }
    hull() {
      translate([12.397, 42.498]) circle(r = 8.5);
      translate([30, 46]) circle(r = 8.5);
    }
    hull() {
      translate([30, 46]) circle(r = 8.5);
      translate([93.603, 49.502]) circle(r = 8.5);
    }
    hull() {
      translate([93.603, 49.502]) circle(r = 8.5);
      translate([108.527, 59.473]) circle(r = 8.5);
    }
    hull() {
      translate([108.527, 59.473]) circle(r = 8.5);
      translate([118.498, 74.397]) circle(r = 8.5);
    }
    hull() {
      translate([118.498, 74.397]) circle(r = 8.5);
      translate([122.975, 96.904]) circle(r = 8.5);
    }
  }
  translate([-16, 0]) rotate([0, 0, -11.25]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([-16, 0]) rotate([0, 0, -11.25]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([122, 92]) rotate([0, 0, 168.75]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([122, 92]) rotate([0, 0, 168.75]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
}
