$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 2.5 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 26.9;            // port flange half width
port_d = 53.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 21.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[20.383, -5.248], [-32.383, 5.248], [-30.822, 13.094], [21.944, 2.598]]);
      translate([-3.854, 10.789]) circle(r = 17);
    }
    hull() {
      translate([-3.854, 10.789]) circle(r = 17);
      translate([-2.498, 17.603]) circle(r = 17);
    }
    hull() {
      translate([-2.498, 17.603]) circle(r = 17);
      translate([7.473, 32.527]) circle(r = 17);
    }
    hull() {
      translate([7.473, 32.527]) circle(r = 17);
      translate([22.397, 42.498]) circle(r = 17);
    }
    hull() {
      translate([22.397, 42.498]) circle(r = 17);
      translate([40, 46]) circle(r = 17);
    }
    hull() {
      translate([40, 46]) circle(r = 17);
      translate([103.603, 49.502]) circle(r = 17);
    }
    hull() {
      translate([103.603, 49.502]) circle(r = 17);
      translate([118.527, 59.473]) circle(r = 17);
    }
    hull() {
      translate([118.527, 59.473]) circle(r = 17);
      translate([128.498, 74.397]) circle(r = 17);
    }
    hull() {
      translate([128.498, 74.397]) circle(r = 17);
      translate([129.854, 81.211]) circle(r = 17);
    }
    hull() {
      translate([129.854, 81.211]) circle(r = 17);
      polygon([[105.617, 97.248], [158.383, 86.752], [156.822, 78.906], [104.056, 89.402]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 33) {
    hull() {
      translate([-6.975, -4.904]) circle(r = 14.5);
      translate([-2.498, 17.603]) circle(r = 14.5);
    }
    hull() {
      translate([-2.498, 17.603]) circle(r = 14.5);
      translate([7.473, 32.527]) circle(r = 14.5);
    }
    hull() {
      translate([7.473, 32.527]) circle(r = 14.5);
      translate([22.397, 42.498]) circle(r = 14.5);
    }
    hull() {
      translate([22.397, 42.498]) circle(r = 14.5);
      translate([40, 46]) circle(r = 14.5);
    }
    hull() {
      translate([40, 46]) circle(r = 14.5);
      translate([103.603, 49.502]) circle(r = 14.5);
    }
    hull() {
      translate([103.603, 49.502]) circle(r = 14.5);
      translate([118.527, 59.473]) circle(r = 14.5);
    }
    hull() {
      translate([118.527, 59.473]) circle(r = 14.5);
      translate([128.498, 74.397]) circle(r = 14.5);
    }
    hull() {
      translate([128.498, 74.397]) circle(r = 14.5);
      translate([132.975, 96.904]) circle(r = 14.5);
    }
  }
  translate([-6, 0]) rotate([0, 0, -11.25]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([-6, 0]) rotate([0, 0, -11.25]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([132, 92]) rotate([0, 0, 168.75]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([132, 92]) rotate([0, 0, 168.75]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
