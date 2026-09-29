$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 3 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 26.9;            // port flange half width
port_d = 53.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 21.7;       // bolt hole offset from the port axis
branch_r = 12.75;         // branch core radius
branch_d = 25.5;          // branch core diameter
branch_len = 60;          // branch length from the run axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[0, -26.9], [0, 26.9], [6, 26.9], [6, -26.9]]);
      translate([9, 0]) circle(r = 17);
    }
    hull() {
      translate([9, 0]) circle(r = 17);
      translate([39, 0]) circle(r = 17);
    }
    hull() {
      translate([39, 0]) circle(r = 17);
      translate([91, 0]) circle(r = 17);
    }
    hull() {
      translate([91, 0]) circle(r = 17);
      translate([121, 0]) circle(r = 17);
    }
    hull() {
      translate([121, 0]) circle(r = 17);
      polygon([[130, 26.9], [130, -26.9], [124, -26.9], [124, 26.9]]);
    }
    hull() {
      translate([91, 0]) circle(r = 12.75);
      translate([91, 33]) circle(r = 12.75);
    }
    hull() {
      translate([91, 33]) circle(r = 12.75);
      translate([91, 52]) circle(r = 12.75);
    }
    hull() {
      translate([91, 52]) circle(r = 12.75);
      polygon([[64.1, 60], [117.9, 60], [117.9, 54], [64.1, 54]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 32) {
    hull() {
      translate([-5, 0]) circle(r = 14);
      translate([39, 0]) circle(r = 14);
    }
    hull() {
      translate([39, 0]) circle(r = 14);
      translate([91, 0]) circle(r = 14);
    }
    hull() {
      translate([91, 0]) circle(r = 14);
      translate([135, 0]) circle(r = 14);
    }
    hull() {
      translate([91, 0]) circle(r = 9.75);
      translate([91, 33]) circle(r = 9.75);
    }
    hull() {
      translate([91, 33]) circle(r = 9.75);
      translate([91, 65]) circle(r = 9.75);
    }
  }
  translate([0, 0]) rotate([0, 0, -90]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([0, 0]) rotate([0, 0, -90]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([130, 0]) rotate([0, 0, 90]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([91, 60]) rotate([0, 0, 180]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([91, 60]) rotate([0, 0, 180]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
