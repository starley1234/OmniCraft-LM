$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 4 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 22.9;            // port flange half width
port_d = 45.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 18.2;       // bolt hole offset from the port axis
branch_r = 11.9;          // branch core radius
branch_d = 23.8;          // branch core diameter
branch_len = 50;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[0, -22.9], [0, 22.9], [7, 22.9], [7, -22.9]]);
      translate([10, 0]) circle(r = 14);
    }
    hull() {
      translate([10, 0]) circle(r = 14);
      translate([45, 0]) circle(r = 14);
    }
    hull() {
      translate([45, 0]) circle(r = 14);
      translate([105, 0]) circle(r = 14);
    }
    hull() {
      translate([105, 0]) circle(r = 14);
      translate([140, 0]) circle(r = 14);
    }
    hull() {
      translate([140, 0]) circle(r = 14);
      polygon([[150, 22.9], [150, -22.9], [143, -22.9], [143, 22.9]]);
    }
    hull() {
      translate([105, 0]) circle(r = 11.9);
      translate([105, 27.5]) circle(r = 11.9);
    }
    hull() {
      translate([105, 27.5]) circle(r = 11.9);
      translate([105, 41]) circle(r = 11.9);
    }
    hull() {
      translate([105, 41]) circle(r = 11.9);
      polygon([[82.1, 50], [127.9, 50], [127.9, 43], [82.1, 43]]);
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
      translate([105, 0]) circle(r = 7.9);
      translate([105, 27.5]) circle(r = 7.9);
    }
    hull() {
      translate([105, 27.5]) circle(r = 7.9);
      translate([105, 55]) circle(r = 7.9);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([105, 50]) rotate([0, 0, 180]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([105, 50]) rotate([0, 0, 180]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
