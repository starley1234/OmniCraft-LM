$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 3 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 21.9;            // port flange half width
port_d = 43.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 16.7;       // bolt hole offset from the port axis
branch_r = 9;             // branch core radius
branch_d = 18;            // branch core diameter
branch_len = 70;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[0, -21.9], [0, 21.9], [6, 21.9], [6, -21.9]]);
      translate([9, 0]) circle(r = 12);
    }
    hull() {
      translate([9, 0]) circle(r = 12);
      translate([45, 0]) circle(r = 12);
    }
    hull() {
      translate([45, 0]) circle(r = 12);
      translate([105, 0]) circle(r = 12);
    }
    hull() {
      translate([105, 0]) circle(r = 12);
      translate([141, 0]) circle(r = 12);
    }
    hull() {
      translate([141, 0]) circle(r = 12);
      polygon([[150, 21.9], [150, -21.9], [144, -21.9], [144, 21.9]]);
    }
    hull() {
      translate([105, 0]) circle(r = 9);
      translate([105, 38.5]) circle(r = 9);
    }
    hull() {
      translate([105, 38.5]) circle(r = 9);
      translate([105, 62]) circle(r = 9);
    }
    hull() {
      translate([105, 62]) circle(r = 9);
      polygon([[83.1, 70], [126.9, 70], [126.9, 64], [83.1, 64]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 38) {
    hull() {
      translate([-5, 0]) circle(r = 9);
      translate([45, 0]) circle(r = 9);
    }
    hull() {
      translate([45, 0]) circle(r = 9);
      translate([105, 0]) circle(r = 9);
    }
    hull() {
      translate([105, 0]) circle(r = 9);
      translate([155, 0]) circle(r = 9);
    }
    hull() {
      translate([105, 0]) circle(r = 6);
      translate([105, 38.5]) circle(r = 6);
    }
    hull() {
      translate([105, 38.5]) circle(r = 6);
      translate([105, 75]) circle(r = 6);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([105, 70]) rotate([0, 0, 180]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([105, 70]) rotate([0, 0, 180]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
