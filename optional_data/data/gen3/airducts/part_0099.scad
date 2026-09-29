$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 3.5 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 26.9;            // port flange half width
port_d = 53.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 21.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[30.383, -5.248], [-22.383, 5.248], [-21.213, 11.133], [31.554, 0.637]]);
      translate([5.756, 8.827]) circle(r = 17);
    }
    hull() {
      translate([5.756, 8.827]) circle(r = 17);
      translate([7.502, 17.603]) circle(r = 17);
    }
    hull() {
      translate([7.502, 17.603]) circle(r = 17);
      translate([17.473, 32.527]) circle(r = 17);
    }
    hull() {
      translate([17.473, 32.527]) circle(r = 17);
      translate([32.397, 42.498]) circle(r = 17);
    }
    hull() {
      translate([32.397, 42.498]) circle(r = 17);
      translate([50, 46]) circle(r = 17);
    }
    hull() {
      translate([50, 46]) circle(r = 17);
      translate([113.603, 49.502]) circle(r = 17);
    }
    hull() {
      translate([113.603, 49.502]) circle(r = 17);
      translate([128.527, 59.473]) circle(r = 17);
    }
    hull() {
      translate([128.527, 59.473]) circle(r = 17);
      translate([138.498, 74.397]) circle(r = 17);
    }
    hull() {
      translate([138.498, 74.397]) circle(r = 17);
      translate([140.244, 83.173]) circle(r = 17);
    }
    hull() {
      translate([140.244, 83.173]) circle(r = 17);
      polygon([[115.617, 97.248], [168.383, 86.752], [167.213, 80.867], [114.446, 91.363]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 31) {
    hull() {
      translate([3.025, -4.904]) circle(r = 13.5);
      translate([7.502, 17.603]) circle(r = 13.5);
    }
    hull() {
      translate([7.502, 17.603]) circle(r = 13.5);
      translate([17.473, 32.527]) circle(r = 13.5);
    }
    hull() {
      translate([17.473, 32.527]) circle(r = 13.5);
      translate([32.397, 42.498]) circle(r = 13.5);
    }
    hull() {
      translate([32.397, 42.498]) circle(r = 13.5);
      translate([50, 46]) circle(r = 13.5);
    }
    hull() {
      translate([50, 46]) circle(r = 13.5);
      translate([113.603, 49.502]) circle(r = 13.5);
    }
    hull() {
      translate([113.603, 49.502]) circle(r = 13.5);
      translate([128.527, 59.473]) circle(r = 13.5);
    }
    hull() {
      translate([128.527, 59.473]) circle(r = 13.5);
      translate([138.498, 74.397]) circle(r = 13.5);
    }
    hull() {
      translate([138.498, 74.397]) circle(r = 13.5);
      translate([142.975, 96.904]) circle(r = 13.5);
    }
  }
  translate([4, 0]) rotate([0, 0, -11.25]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([4, 0]) rotate([0, 0, -11.25]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([142, 92]) rotate([0, 0, 168.75]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([142, 92]) rotate([0, 0, 168.75]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
