$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 2.5 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 23.9;            // port flange half width
port_d = 47.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 18.7;       // bolt hole offset from the port axis
branch_r = 10.5;          // branch core radius
branch_d = 21;            // branch core diameter
branch_len = 60;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[0, -23.9], [0, 23.9], [7, 23.9], [7, -23.9]]);
      translate([10, 0]) circle(r = 14);
    }
    hull() {
      translate([10, 0]) circle(r = 14);
      translate([33, 0]) circle(r = 14);
    }
    hull() {
      translate([33, 0]) circle(r = 14);
      translate([77, 0]) circle(r = 14);
    }
    hull() {
      translate([77, 0]) circle(r = 14);
      translate([100, 0]) circle(r = 14);
    }
    hull() {
      translate([100, 0]) circle(r = 14);
      polygon([[110, 23.9], [110, -23.9], [103, -23.9], [103, 23.9]]);
    }
    hull() {
      translate([77, 0]) circle(r = 10.5);
      translate([77, 33]) circle(r = 10.5);
    }
    hull() {
      translate([77, 33]) circle(r = 10.5);
      translate([77, 51]) circle(r = 10.5);
    }
    hull() {
      translate([77, 51]) circle(r = 10.5);
      polygon([[53.1, 60], [100.9, 60], [100.9, 53], [53.1, 53]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 27) {
    hull() {
      translate([-5, 0]) circle(r = 11.5);
      translate([33, 0]) circle(r = 11.5);
    }
    hull() {
      translate([33, 0]) circle(r = 11.5);
      translate([77, 0]) circle(r = 11.5);
    }
    hull() {
      translate([77, 0]) circle(r = 11.5);
      translate([115, 0]) circle(r = 11.5);
    }
    hull() {
      translate([77, 0]) circle(r = 8);
      translate([77, 33]) circle(r = 8);
    }
    hull() {
      translate([77, 33]) circle(r = 8);
      translate([77, 65]) circle(r = 8);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([110, 0]) rotate([0, 0, 90]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([110, 0]) rotate([0, 0, 90]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([77, 60]) rotate([0, 0, 180]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([77, 60]) rotate([0, 0, 180]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
}
