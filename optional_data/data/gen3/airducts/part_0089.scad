$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 3.5 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 18.9;            // port flange half width
port_d = 37.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 14.2;       // bolt hole offset from the port axis
branch_r = 7.5;           // branch core radius
branch_d = 15;            // branch core diameter
branch_len = 60;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[0, -18.9], [0, 18.9], [7, 18.9], [7, -18.9]]);
      translate([10, 0]) circle(r = 10);
    }
    hull() {
      translate([10, 0]) circle(r = 10);
      translate([39, 0]) circle(r = 10);
    }
    hull() {
      translate([39, 0]) circle(r = 10);
      translate([91, 0]) circle(r = 10);
    }
    hull() {
      translate([91, 0]) circle(r = 10);
      translate([120, 0]) circle(r = 10);
    }
    hull() {
      translate([120, 0]) circle(r = 10);
      polygon([[130, 18.9], [130, -18.9], [123, -18.9], [123, 18.9]]);
    }
    hull() {
      translate([91, 0]) circle(r = 7.5);
      translate([91, 33]) circle(r = 7.5);
    }
    hull() {
      translate([91, 33]) circle(r = 7.5);
      translate([91, 51]) circle(r = 7.5);
    }
    hull() {
      translate([91, 51]) circle(r = 7.5);
      polygon([[72.1, 60], [109.9, 60], [109.9, 53], [72.1, 53]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 25) {
    hull() {
      translate([-5, 0]) circle(r = 6.5);
      translate([39, 0]) circle(r = 6.5);
    }
    hull() {
      translate([39, 0]) circle(r = 6.5);
      translate([91, 0]) circle(r = 6.5);
    }
    hull() {
      translate([91, 0]) circle(r = 6.5);
      translate([135, 0]) circle(r = 6.5);
    }
    hull() {
      translate([91, 0]) circle(r = 4);
      translate([91, 33]) circle(r = 4);
    }
    hull() {
      translate([91, 33]) circle(r = 4);
      translate([91, 65]) circle(r = 4);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([91, 60]) rotate([0, 0, 180]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([91, 60]) rotate([0, 0, 180]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
