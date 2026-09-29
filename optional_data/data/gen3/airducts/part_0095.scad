$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 4 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 23.9;            // port flange half width
port_d = 47.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 18.7;       // bolt hole offset from the port axis
branch_r = 11.9;          // branch core radius
branch_d = 23.8;          // branch core diameter
branch_len = 60;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[0, -23.9], [0, 23.9], [6, 23.9], [6, -23.9]]);
      translate([9, 0]) circle(r = 14);
    }
    hull() {
      translate([9, 0]) circle(r = 14);
      translate([39, 0]) circle(r = 14);
    }
    hull() {
      translate([39, 0]) circle(r = 14);
      translate([91, 0]) circle(r = 14);
    }
    hull() {
      translate([91, 0]) circle(r = 14);
      translate([121, 0]) circle(r = 14);
    }
    hull() {
      translate([121, 0]) circle(r = 14);
      polygon([[130, 23.9], [130, -23.9], [124, -23.9], [124, 23.9]]);
    }
    hull() {
      translate([91, 0]) circle(r = 11.9);
      translate([91, 33]) circle(r = 11.9);
    }
    hull() {
      translate([91, 33]) circle(r = 11.9);
      translate([91, 52]) circle(r = 11.9);
    }
    hull() {
      translate([91, 52]) circle(r = 11.9);
      polygon([[67.1, 60], [114.9, 60], [114.9, 54], [67.1, 54]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 36) {
    hull() {
      translate([-5, 0]) circle(r = 10);
      translate([39, 0]) circle(r = 10);
    }
    hull() {
      translate([39, 0]) circle(r = 10);
      translate([91, 0]) circle(r = 10);
    }
    hull() {
      translate([91, 0]) circle(r = 10);
      translate([135, 0]) circle(r = 10);
    }
    hull() {
      translate([91, 0]) circle(r = 7.9);
      translate([91, 33]) circle(r = 7.9);
    }
    hull() {
      translate([91, 33]) circle(r = 7.9);
      translate([91, 65]) circle(r = 7.9);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([91, 60]) rotate([0, 0, 180]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([91, 60]) rotate([0, 0, 180]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
