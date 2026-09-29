$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 2.5 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 19.9;            // port flange half width
port_d = 39.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 14.7;       // bolt hole offset from the port axis
branch_r = 7.5;           // branch core radius
branch_d = 15;            // branch core diameter
branch_len = 70;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[0, -19.9], [0, 19.9], [7, 19.9], [7, -19.9]]);
      translate([10, 0]) circle(r = 10);
    }
    hull() {
      translate([10, 0]) circle(r = 10);
      translate([33, 0]) circle(r = 10);
    }
    hull() {
      translate([33, 0]) circle(r = 10);
      translate([77, 0]) circle(r = 10);
    }
    hull() {
      translate([77, 0]) circle(r = 10);
      translate([100, 0]) circle(r = 10);
    }
    hull() {
      translate([100, 0]) circle(r = 10);
      polygon([[110, 19.9], [110, -19.9], [103, -19.9], [103, 19.9]]);
    }
    hull() {
      translate([77, 0]) circle(r = 7.5);
      translate([77, 38.5]) circle(r = 7.5);
    }
    hull() {
      translate([77, 38.5]) circle(r = 7.5);
      translate([77, 61]) circle(r = 7.5);
    }
    hull() {
      translate([77, 61]) circle(r = 7.5);
      polygon([[57.1, 70], [96.9, 70], [96.9, 63], [57.1, 63]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 39) {
    hull() {
      translate([-5, 0]) circle(r = 7.5);
      translate([33, 0]) circle(r = 7.5);
    }
    hull() {
      translate([33, 0]) circle(r = 7.5);
      translate([77, 0]) circle(r = 7.5);
    }
    hull() {
      translate([77, 0]) circle(r = 7.5);
      translate([115, 0]) circle(r = 7.5);
    }
    hull() {
      translate([77, 0]) circle(r = 5);
      translate([77, 38.5]) circle(r = 5);
    }
    hull() {
      translate([77, 38.5]) circle(r = 5);
      translate([77, 75]) circle(r = 5);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([110, 0]) rotate([0, 0, 90]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([110, 0]) rotate([0, 0, 90]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([77, 70]) rotate([0, 0, 180]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([77, 70]) rotate([0, 0, 180]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
}
