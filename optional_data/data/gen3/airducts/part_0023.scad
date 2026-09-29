$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 4 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 23.9;            // port flange half width
port_d = 47.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 18.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[2.676, -23.75], [-2.676, 23.75], [5.274, 24.645], [10.626, -22.854]]);
      translate([10.931, 1.232]) circle(r = 14);
    }
    hull() {
      translate([10.931, 1.232]) circle(r = 14);
      translate([10.236, 1.153]) circle(r = 14);
    }
    hull() {
      translate([10.236, 1.153]) circle(r = 14);
      translate([19.959, 4.555]) circle(r = 14);
    }
    hull() {
      translate([19.959, 4.555]) circle(r = 14);
      translate([28.681, 10.036]) circle(r = 14);
    }
    hull() {
      translate([28.681, 10.036]) circle(r = 14);
      translate([35.964, 17.319]) circle(r = 14);
    }
    hull() {
      translate([35.964, 17.319]) circle(r = 14);
      translate([41.445, 26.041]) circle(r = 14);
    }
    hull() {
      translate([41.445, 26.041]) circle(r = 14);
      translate([44.847, 35.764]) circle(r = 14);
    }
    hull() {
      translate([44.847, 35.764]) circle(r = 14);
      translate([44.768, 35.069]) circle(r = 14);
    }
    hull() {
      translate([44.768, 35.069]) circle(r = 14);
      polygon([[22.25, 48.676], [69.75, 43.324], [68.854, 35.374], [21.355, 40.726]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 30) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 10);
      translate([10.236, 1.153]) circle(r = 10);
    }
    hull() {
      translate([10.236, 1.153]) circle(r = 10);
      translate([19.959, 4.555]) circle(r = 10);
    }
    hull() {
      translate([19.959, 4.555]) circle(r = 10);
      translate([28.681, 10.036]) circle(r = 10);
    }
    hull() {
      translate([28.681, 10.036]) circle(r = 10);
      translate([35.964, 17.319]) circle(r = 10);
    }
    hull() {
      translate([35.964, 17.319]) circle(r = 10);
      translate([41.445, 26.041]) circle(r = 10);
    }
    hull() {
      translate([41.445, 26.041]) circle(r = 10);
      translate([44.847, 35.764]) circle(r = 10);
    }
    hull() {
      translate([44.847, 35.764]) circle(r = 10);
      translate([46.56, 50.969]) circle(r = 10);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([46, 46]) rotate([0, 0, 173.57]) translate([-18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([46, 46]) rotate([0, 0, 173.57]) translate([18.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
