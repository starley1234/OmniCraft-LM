$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 4 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 25.9;            // port flange half width
port_d = 51.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 21.2;       // bolt hole offset from the port axis
branch_r = 14.45;         // branch core radius
branch_d = 28.9;          // branch core diameter
branch_len = 60;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[0, -25.9], [0, 25.9], [7, 25.9], [7, -25.9]]);
      translate([10, 0]) circle(r = 17);
    }
    hull() {
      translate([10, 0]) circle(r = 17);
      translate([45, 0]) circle(r = 17);
    }
    hull() {
      translate([45, 0]) circle(r = 17);
      translate([105, 0]) circle(r = 17);
    }
    hull() {
      translate([105, 0]) circle(r = 17);
      translate([140, 0]) circle(r = 17);
    }
    hull() {
      translate([140, 0]) circle(r = 17);
      polygon([[150, 25.9], [150, -25.9], [143, -25.9], [143, 25.9]]);
    }
    hull() {
      translate([105, 0]) circle(r = 14.45);
      translate([105, 33]) circle(r = 14.45);
    }
    hull() {
      translate([105, 33]) circle(r = 14.45);
      translate([105, 51]) circle(r = 14.45);
    }
    hull() {
      translate([105, 51]) circle(r = 14.45);
      polygon([[79.1, 60], [130.9, 60], [130.9, 53], [79.1, 53]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 30) {
    hull() {
      translate([-5, 0]) circle(r = 13);
      translate([45, 0]) circle(r = 13);
    }
    hull() {
      translate([45, 0]) circle(r = 13);
      translate([105, 0]) circle(r = 13);
    }
    hull() {
      translate([105, 0]) circle(r = 13);
      translate([155, 0]) circle(r = 13);
    }
    hull() {
      translate([105, 0]) circle(r = 10.45);
      translate([105, 33]) circle(r = 10.45);
    }
    hull() {
      translate([105, 33]) circle(r = 10.45);
      translate([105, 65]) circle(r = 10.45);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([105, 60]) rotate([0, 0, 180]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([105, 60]) rotate([0, 0, 180]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
