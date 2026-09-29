$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 3 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 18.9;            // port flange half width
port_d = 37.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 14.2;       // bolt hole offset from the port axis
branch_r = 7.5;           // branch core radius
branch_d = 15;            // branch core diameter
branch_len = 50;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[0, -18.9], [0, 18.9], [6, 18.9], [6, -18.9]]);
      translate([9, 0]) circle(r = 10);
    }
    hull() {
      translate([9, 0]) circle(r = 10);
      translate([45, 0]) circle(r = 10);
    }
    hull() {
      translate([45, 0]) circle(r = 10);
      translate([105, 0]) circle(r = 10);
    }
    hull() {
      translate([105, 0]) circle(r = 10);
      translate([141, 0]) circle(r = 10);
    }
    hull() {
      translate([141, 0]) circle(r = 10);
      polygon([[150, 18.9], [150, -18.9], [144, -18.9], [144, 18.9]]);
    }
    hull() {
      translate([105, 0]) circle(r = 7.5);
      translate([105, 27.5]) circle(r = 7.5);
    }
    hull() {
      translate([105, 27.5]) circle(r = 7.5);
      translate([105, 42]) circle(r = 7.5);
    }
    hull() {
      translate([105, 42]) circle(r = 7.5);
      polygon([[86.1, 50], [123.9, 50], [123.9, 44], [86.1, 44]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 38) {
    hull() {
      translate([-5, 0]) circle(r = 7);
      translate([45, 0]) circle(r = 7);
    }
    hull() {
      translate([45, 0]) circle(r = 7);
      translate([105, 0]) circle(r = 7);
    }
    hull() {
      translate([105, 0]) circle(r = 7);
      translate([155, 0]) circle(r = 7);
    }
    hull() {
      translate([105, 0]) circle(r = 4.5);
      translate([105, 27.5]) circle(r = 4.5);
    }
    hull() {
      translate([105, 27.5]) circle(r = 4.5);
      translate([105, 55]) circle(r = 4.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([150, 0]) rotate([0, 0, 90]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([105, 50]) rotate([0, 0, 180]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([105, 50]) rotate([0, 0, 180]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
}
