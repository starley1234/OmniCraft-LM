$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 3 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 22.9;            // port flange half width
port_d = 45.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 18.2;       // bolt hole offset from the port axis
branch_r = 10.5;          // branch core radius
branch_d = 21;            // branch core diameter
branch_len = 70;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[0, -22.9], [0, 22.9], [8, 22.9], [8, -22.9]]);
      translate([11, 0]) circle(r = 14);
    }
    hull() {
      translate([11, 0]) circle(r = 14);
      translate([39, 0]) circle(r = 14);
    }
    hull() {
      translate([39, 0]) circle(r = 14);
      translate([91, 0]) circle(r = 14);
    }
    hull() {
      translate([91, 0]) circle(r = 14);
      translate([119, 0]) circle(r = 14);
    }
    hull() {
      translate([119, 0]) circle(r = 14);
      polygon([[130, 22.9], [130, -22.9], [122, -22.9], [122, 22.9]]);
    }
    hull() {
      translate([91, 0]) circle(r = 10.5);
      translate([91, 38.5]) circle(r = 10.5);
    }
    hull() {
      translate([91, 38.5]) circle(r = 10.5);
      translate([91, 60]) circle(r = 10.5);
    }
    hull() {
      translate([91, 60]) circle(r = 10.5);
      polygon([[68.1, 70], [113.9, 70], [113.9, 62], [68.1, 62]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 26) {
    hull() {
      translate([-5, 0]) circle(r = 11);
      translate([39, 0]) circle(r = 11);
    }
    hull() {
      translate([39, 0]) circle(r = 11);
      translate([91, 0]) circle(r = 11);
    }
    hull() {
      translate([91, 0]) circle(r = 11);
      translate([135, 0]) circle(r = 11);
    }
    hull() {
      translate([91, 0]) circle(r = 7.5);
      translate([91, 38.5]) circle(r = 7.5);
    }
    hull() {
      translate([91, 38.5]) circle(r = 7.5);
      translate([91, 75]) circle(r = 7.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([91, 70]) rotate([0, 0, 180]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([91, 70]) rotate([0, 0, 180]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
}
