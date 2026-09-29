$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 2.5 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 19.9;            // port flange half width
port_d = 39.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 14.7;       // bolt hole offset from the port axis
branch_r = 7.5;           // branch core radius
branch_d = 15;            // branch core diameter
branch_len = 50;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[0, -19.9], [0, 19.9], [8, 19.9], [8, -19.9]]);
      translate([11, 0]) circle(r = 10);
    }
    hull() {
      translate([11, 0]) circle(r = 10);
      translate([39, 0]) circle(r = 10);
    }
    hull() {
      translate([39, 0]) circle(r = 10);
      translate([91, 0]) circle(r = 10);
    }
    hull() {
      translate([91, 0]) circle(r = 10);
      translate([119, 0]) circle(r = 10);
    }
    hull() {
      translate([119, 0]) circle(r = 10);
      polygon([[130, 19.9], [130, -19.9], [122, -19.9], [122, 19.9]]);
    }
    hull() {
      translate([91, 0]) circle(r = 7.5);
      translate([91, 27.5]) circle(r = 7.5);
    }
    hull() {
      translate([91, 27.5]) circle(r = 7.5);
      translate([91, 40]) circle(r = 7.5);
    }
    hull() {
      translate([91, 40]) circle(r = 7.5);
      polygon([[71.1, 50], [110.9, 50], [110.9, 42], [71.1, 42]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 33) {
    hull() {
      translate([-5, 0]) circle(r = 7.5);
      translate([39, 0]) circle(r = 7.5);
    }
    hull() {
      translate([39, 0]) circle(r = 7.5);
      translate([91, 0]) circle(r = 7.5);
    }
    hull() {
      translate([91, 0]) circle(r = 7.5);
      translate([135, 0]) circle(r = 7.5);
    }
    hull() {
      translate([91, 0]) circle(r = 5);
      translate([91, 27.5]) circle(r = 5);
    }
    hull() {
      translate([91, 27.5]) circle(r = 5);
      translate([91, 55]) circle(r = 5);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([91, 50]) rotate([0, 0, 180]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([91, 50]) rotate([0, 0, 180]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
