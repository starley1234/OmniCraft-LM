$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 3.5 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 26.9;            // port flange half width
port_d = 53.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 21.7;       // bolt hole offset from the port axis
branch_r = 14.45;         // branch core radius
branch_d = 28.9;          // branch core diameter
branch_len = 50;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[0, -26.9], [0, 26.9], [8, 26.9], [8, -26.9]]);
      translate([11, 0]) circle(r = 17);
    }
    hull() {
      translate([11, 0]) circle(r = 17);
      translate([45, 0]) circle(r = 17);
    }
    hull() {
      translate([45, 0]) circle(r = 17);
      translate([105, 0]) circle(r = 17);
    }
    hull() {
      translate([105, 0]) circle(r = 17);
      translate([139, 0]) circle(r = 17);
    }
    hull() {
      translate([139, 0]) circle(r = 17);
      polygon([[150, 26.9], [150, -26.9], [142, -26.9], [142, 26.9]]);
    }
    hull() {
      translate([105, 0]) circle(r = 14.45);
      translate([105, 27.5]) circle(r = 14.45);
    }
    hull() {
      translate([105, 27.5]) circle(r = 14.45);
      translate([105, 40]) circle(r = 14.45);
    }
    hull() {
      translate([105, 40]) circle(r = 14.45);
      polygon([[78.1, 50], [131.9, 50], [131.9, 42], [78.1, 42]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 19) {
    hull() {
      translate([-5, 0]) circle(r = 13.5);
      translate([45, 0]) circle(r = 13.5);
    }
    hull() {
      translate([45, 0]) circle(r = 13.5);
      translate([105, 0]) circle(r = 13.5);
    }
    hull() {
      translate([105, 0]) circle(r = 13.5);
      translate([155, 0]) circle(r = 13.5);
    }
    hull() {
      translate([105, 0]) circle(r = 10.95);
      translate([105, 27.5]) circle(r = 10.95);
    }
    hull() {
      translate([105, 27.5]) circle(r = 10.95);
      translate([105, 55]) circle(r = 10.95);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([105, 50]) rotate([0, 0, 180]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([105, 50]) rotate([0, 0, 180]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
