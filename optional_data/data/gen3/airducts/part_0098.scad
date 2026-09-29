$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 3.5 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 23.9;            // port flange half width
port_d = 47.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 18.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[17.441, -4.663], [-29.441, 4.663], [-28.27, 10.547], [18.611, 1.222]]);
      translate([-4.244, 8.827]) circle(r = 14);
    }
    hull() {
      translate([-4.244, 8.827]) circle(r = 14);
      translate([-2.498, 17.603]) circle(r = 14);
    }
    hull() {
      translate([-2.498, 17.603]) circle(r = 14);
      translate([7.473, 32.527]) circle(r = 14);
    }
    hull() {
      translate([7.473, 32.527]) circle(r = 14);
      translate([22.397, 42.498]) circle(r = 14);
    }
    hull() {
      translate([22.397, 42.498]) circle(r = 14);
      translate([40, 46]) circle(r = 14);
    }
    hull() {
      translate([40, 46]) circle(r = 14);
      translate([103.603, 49.502]) circle(r = 14);
    }
    hull() {
      translate([103.603, 49.502]) circle(r = 14);
      translate([118.527, 59.473]) circle(r = 14);
    }
    hull() {
      translate([118.527, 59.473]) circle(r = 14);
      translate([128.498, 74.397]) circle(r = 14);
    }
    hull() {
      translate([128.498, 74.397]) circle(r = 14);
      translate([130.244, 83.173]) circle(r = 14);
    }
    hull() {
      translate([130.244, 83.173]) circle(r = 14);
      polygon([[108.559, 96.663], [155.441, 87.337], [154.27, 81.453], [107.389, 90.778]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 19) {
    hull() {
      translate([-6.975, -4.904]) circle(r = 10.5);
      translate([-2.498, 17.603]) circle(r = 10.5);
    }
    hull() {
      translate([-2.498, 17.603]) circle(r = 10.5);
      translate([7.473, 32.527]) circle(r = 10.5);
    }
    hull() {
      translate([7.473, 32.527]) circle(r = 10.5);
      translate([22.397, 42.498]) circle(r = 10.5);
    }
    hull() {
      translate([22.397, 42.498]) circle(r = 10.5);
      translate([40, 46]) circle(r = 10.5);
    }
    hull() {
      translate([40, 46]) circle(r = 10.5);
      translate([103.603, 49.502]) circle(r = 10.5);
    }
    hull() {
      translate([103.603, 49.502]) circle(r = 10.5);
      translate([118.527, 59.473]) circle(r = 10.5);
    }
    hull() {
      translate([118.527, 59.473]) circle(r = 10.5);
      translate([128.498, 74.397]) circle(r = 10.5);
    }
    hull() {
      translate([128.498, 74.397]) circle(r = 10.5);
      translate([132.975, 96.904]) circle(r = 10.5);
    }
  }
  translate([-6, 0]) rotate([0, 0, -11.25]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([-6, 0]) rotate([0, 0, -11.25]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([132, 92]) rotate([0, 0, 168.75]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([132, 92]) rotate([0, 0, 168.75]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
