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
port_t = 6;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 21.2;       // bolt hole offset from the port axis
branch_r = 12.75;         // branch core radius
branch_d = 25.5;          // branch core diameter
branch_len = 70;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[0, -25.9], [0, 25.9], [6, 25.9], [6, -25.9]]);
      translate([9, 0]) circle(r = 17);
    }
    hull() {
      translate([9, 0]) circle(r = 17);
      translate([33, 0]) circle(r = 17);
    }
    hull() {
      translate([33, 0]) circle(r = 17);
      translate([77, 0]) circle(r = 17);
    }
    hull() {
      translate([77, 0]) circle(r = 17);
      translate([101, 0]) circle(r = 17);
    }
    hull() {
      translate([101, 0]) circle(r = 17);
      polygon([[110, 25.9], [110, -25.9], [104, -25.9], [104, 25.9]]);
    }
    hull() {
      translate([77, 0]) circle(r = 12.75);
      translate([77, 38.5]) circle(r = 12.75);
    }
    hull() {
      translate([77, 38.5]) circle(r = 12.75);
      translate([77, 62]) circle(r = 12.75);
    }
    hull() {
      translate([77, 62]) circle(r = 12.75);
      polygon([[51.1, 70], [102.9, 70], [102.9, 64], [51.1, 64]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 30) {
    hull() {
      translate([-5, 0]) circle(r = 13);
      translate([33, 0]) circle(r = 13);
    }
    hull() {
      translate([33, 0]) circle(r = 13);
      translate([77, 0]) circle(r = 13);
    }
    hull() {
      translate([77, 0]) circle(r = 13);
      translate([115, 0]) circle(r = 13);
    }
    hull() {
      translate([77, 0]) circle(r = 8.75);
      translate([77, 38.5]) circle(r = 8.75);
    }
    hull() {
      translate([77, 38.5]) circle(r = 8.75);
      translate([77, 75]) circle(r = 8.75);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([110, 0]) rotate([0, 0, 90]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([110, 0]) rotate([0, 0, 90]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([77, 70]) rotate([0, 0, 180]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([77, 70]) rotate([0, 0, 180]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
}
