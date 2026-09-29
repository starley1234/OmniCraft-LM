$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 4 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 23.9;            // port flange half width
port_d = 47.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 18.7;       // bolt hole offset from the port axis
branch_r = 10.5;          // branch core radius
branch_d = 21;            // branch core diameter
branch_len = 70;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[0, -23.9], [0, 23.9], [6, 23.9], [6, -23.9]]);
      translate([9, 0]) circle(r = 14);
    }
    hull() {
      translate([9, 0]) circle(r = 14);
      translate([45, 0]) circle(r = 14);
    }
    hull() {
      translate([45, 0]) circle(r = 14);
      translate([105, 0]) circle(r = 14);
    }
    hull() {
      translate([105, 0]) circle(r = 14);
      translate([141, 0]) circle(r = 14);
    }
    hull() {
      translate([141, 0]) circle(r = 14);
      polygon([[150, 23.9], [150, -23.9], [144, -23.9], [144, 23.9]]);
    }
    hull() {
      translate([105, 0]) circle(r = 10.5);
      translate([105, 38.5]) circle(r = 10.5);
    }
    hull() {
      translate([105, 38.5]) circle(r = 10.5);
      translate([105, 62]) circle(r = 10.5);
    }
    hull() {
      translate([105, 62]) circle(r = 10.5);
      polygon([[81.1, 70], [128.9, 70], [128.9, 64], [81.1, 64]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 30) {
    hull() {
      translate([-5, 0]) circle(r = 10);
      translate([45, 0]) circle(r = 10);
    }
    hull() {
      translate([45, 0]) circle(r = 10);
      translate([105, 0]) circle(r = 10);
    }
    hull() {
      translate([105, 0]) circle(r = 10);
      translate([155, 0]) circle(r = 10);
    }
    hull() {
      translate([105, 0]) circle(r = 6.5);
      translate([105, 38.5]) circle(r = 6.5);
    }
    hull() {
      translate([105, 38.5]) circle(r = 6.5);
      translate([105, 75]) circle(r = 6.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([105, 70]) rotate([0, 0, 180]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([105, 70]) rotate([0, 0, 180]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
