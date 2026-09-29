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
port_t = 6;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 14.2;       // bolt hole offset from the port axis
branch_r = 8.5;           // branch core radius
branch_d = 17;            // branch core diameter
branch_len = 60;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[0, -18.9], [0, 18.9], [6, 18.9], [6, -18.9]]);
      translate([9, 0]) circle(r = 10);
    }
    hull() {
      translate([9, 0]) circle(r = 10);
      translate([33, 0]) circle(r = 10);
    }
    hull() {
      translate([33, 0]) circle(r = 10);
      translate([77, 0]) circle(r = 10);
    }
    hull() {
      translate([77, 0]) circle(r = 10);
      translate([101, 0]) circle(r = 10);
    }
    hull() {
      translate([101, 0]) circle(r = 10);
      polygon([[110, 18.9], [110, -18.9], [104, -18.9], [104, 18.9]]);
    }
    hull() {
      translate([77, 0]) circle(r = 8.5);
      translate([77, 33]) circle(r = 8.5);
    }
    hull() {
      translate([77, 33]) circle(r = 8.5);
      translate([77, 52]) circle(r = 8.5);
    }
    hull() {
      translate([77, 52]) circle(r = 8.5);
      polygon([[58.1, 60], [95.9, 60], [95.9, 54], [58.1, 54]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 25) {
    hull() {
      translate([-5, 0]) circle(r = 6.5);
      translate([33, 0]) circle(r = 6.5);
    }
    hull() {
      translate([33, 0]) circle(r = 6.5);
      translate([77, 0]) circle(r = 6.5);
    }
    hull() {
      translate([77, 0]) circle(r = 6.5);
      translate([115, 0]) circle(r = 6.5);
    }
    hull() {
      translate([77, 0]) circle(r = 5);
      translate([77, 33]) circle(r = 5);
    }
    hull() {
      translate([77, 33]) circle(r = 5);
      translate([77, 65]) circle(r = 5);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([110, 0]) rotate([0, 0, 90]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([110, 0]) rotate([0, 0, 90]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([77, 60]) rotate([0, 0, 180]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([77, 60]) rotate([0, 0, 180]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
}
