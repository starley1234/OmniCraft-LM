$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 3 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 20.9;            // port flange half width
port_d = 41.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 16.2;       // bolt hole offset from the port axis
branch_r = 9;             // branch core radius
branch_d = 18;            // branch core diameter
branch_len = 50;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[0, -20.9], [0, 20.9], [6, 20.9], [6, -20.9]]);
      translate([9, 0]) circle(r = 12);
    }
    hull() {
      translate([9, 0]) circle(r = 12);
      translate([39, 0]) circle(r = 12);
    }
    hull() {
      translate([39, 0]) circle(r = 12);
      translate([91, 0]) circle(r = 12);
    }
    hull() {
      translate([91, 0]) circle(r = 12);
      translate([121, 0]) circle(r = 12);
    }
    hull() {
      translate([121, 0]) circle(r = 12);
      polygon([[130, 20.9], [130, -20.9], [124, -20.9], [124, 20.9]]);
    }
    hull() {
      translate([91, 0]) circle(r = 9);
      translate([91, 27.5]) circle(r = 9);
    }
    hull() {
      translate([91, 27.5]) circle(r = 9);
      translate([91, 42]) circle(r = 9);
    }
    hull() {
      translate([91, 42]) circle(r = 9);
      polygon([[70.1, 50], [111.9, 50], [111.9, 44], [70.1, 44]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 20) {
    hull() {
      translate([-5, 0]) circle(r = 9);
      translate([39, 0]) circle(r = 9);
    }
    hull() {
      translate([39, 0]) circle(r = 9);
      translate([91, 0]) circle(r = 9);
    }
    hull() {
      translate([91, 0]) circle(r = 9);
      translate([135, 0]) circle(r = 9);
    }
    hull() {
      translate([91, 0]) circle(r = 6);
      translate([91, 27.5]) circle(r = 6);
    }
    hull() {
      translate([91, 27.5]) circle(r = 6);
      translate([91, 55]) circle(r = 6);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([91, 50]) rotate([0, 0, 180]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([91, 50]) rotate([0, 0, 180]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
}
