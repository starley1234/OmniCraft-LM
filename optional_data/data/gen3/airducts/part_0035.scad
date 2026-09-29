$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 3 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 23.9;            // port flange half width
port_d = 47.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 18.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[7.441, -4.663], [-39.441, 4.663], [-38.27, 10.547], [8.611, 1.222]]);
      translate([-14.244, 8.827]) circle(r = 14);
    }
    hull() {
      translate([-14.244, 8.827]) circle(r = 14);
      translate([-12.498, 17.603]) circle(r = 14);
    }
    hull() {
      translate([-12.498, 17.603]) circle(r = 14);
      translate([-2.527, 32.527]) circle(r = 14);
    }
    hull() {
      translate([-2.527, 32.527]) circle(r = 14);
      translate([12.397, 42.498]) circle(r = 14);
    }
    hull() {
      translate([12.397, 42.498]) circle(r = 14);
      translate([30, 46]) circle(r = 14);
    }
    hull() {
      translate([30, 46]) circle(r = 14);
      translate([93.603, 49.502]) circle(r = 14);
    }
    hull() {
      translate([93.603, 49.502]) circle(r = 14);
      translate([108.527, 59.473]) circle(r = 14);
    }
    hull() {
      translate([108.527, 59.473]) circle(r = 14);
      translate([118.498, 74.397]) circle(r = 14);
    }
    hull() {
      translate([118.498, 74.397]) circle(r = 14);
      translate([120.244, 83.173]) circle(r = 14);
    }
    hull() {
      translate([120.244, 83.173]) circle(r = 14);
      polygon([[98.559, 96.663], [145.441, 87.337], [144.27, 81.453], [97.389, 90.778]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 32) {
    hull() {
      translate([-16.975, -4.904]) circle(r = 11);
      translate([-12.498, 17.603]) circle(r = 11);
    }
    hull() {
      translate([-12.498, 17.603]) circle(r = 11);
      translate([-2.527, 32.527]) circle(r = 11);
    }
    hull() {
      translate([-2.527, 32.527]) circle(r = 11);
      translate([12.397, 42.498]) circle(r = 11);
    }
    hull() {
      translate([12.397, 42.498]) circle(r = 11);
      translate([30, 46]) circle(r = 11);
    }
    hull() {
      translate([30, 46]) circle(r = 11);
      translate([93.603, 49.502]) circle(r = 11);
    }
    hull() {
      translate([93.603, 49.502]) circle(r = 11);
      translate([108.527, 59.473]) circle(r = 11);
    }
    hull() {
      translate([108.527, 59.473]) circle(r = 11);
      translate([118.498, 74.397]) circle(r = 11);
    }
    hull() {
      translate([118.498, 74.397]) circle(r = 11);
      translate([122.975, 96.904]) circle(r = 11);
    }
  }
  translate([-16, 0]) rotate([0, 0, -11.25]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([-16, 0]) rotate([0, 0, -11.25]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([122, 92]) rotate([0, 0, 168.75]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([122, 92]) rotate([0, 0, 168.75]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
