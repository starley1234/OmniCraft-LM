$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 2.5 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 21.9;            // port flange half width
port_d = 43.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 16.7;       // bolt hole offset from the port axis
branch_r = 9;             // branch core radius
branch_d = 18;            // branch core diameter
branch_len = 50;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[0, -21.9], [0, 21.9], [7, 21.9], [7, -21.9]]);
      translate([10, 0]) circle(r = 12);
    }
    hull() {
      translate([10, 0]) circle(r = 12);
      translate([45, 0]) circle(r = 12);
    }
    hull() {
      translate([45, 0]) circle(r = 12);
      translate([105, 0]) circle(r = 12);
    }
    hull() {
      translate([105, 0]) circle(r = 12);
      translate([140, 0]) circle(r = 12);
    }
    hull() {
      translate([140, 0]) circle(r = 12);
      polygon([[150, 21.9], [150, -21.9], [143, -21.9], [143, 21.9]]);
    }
    hull() {
      translate([105, 0]) circle(r = 9);
      translate([105, 27.5]) circle(r = 9);
    }
    hull() {
      translate([105, 27.5]) circle(r = 9);
      translate([105, 41]) circle(r = 9);
    }
    hull() {
      translate([105, 41]) circle(r = 9);
      polygon([[83.1, 50], [126.9, 50], [126.9, 43], [83.1, 43]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 33) {
    hull() {
      translate([-5, 0]) circle(r = 9.5);
      translate([45, 0]) circle(r = 9.5);
    }
    hull() {
      translate([45, 0]) circle(r = 9.5);
      translate([105, 0]) circle(r = 9.5);
    }
    hull() {
      translate([105, 0]) circle(r = 9.5);
      translate([155, 0]) circle(r = 9.5);
    }
    hull() {
      translate([105, 0]) circle(r = 6.5);
      translate([105, 27.5]) circle(r = 6.5);
    }
    hull() {
      translate([105, 27.5]) circle(r = 6.5);
      translate([105, 55]) circle(r = 6.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([105, 50]) rotate([0, 0, 180]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([105, 50]) rotate([0, 0, 180]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
}
