$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 4 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 18.9;            // port flange half width
port_d = 37.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 14.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[2.116, -18.781], [-2.116, 18.781], [4.84, 19.565], [9.072, -17.997]]);
      translate([9.937, 1.12]) circle(r = 10);
    }
    hull() {
      translate([9.937, 1.12]) circle(r = 10);
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
      translate([44.88, 36.063]) circle(r = 10);
    }
    hull() {
      translate([44.88, 36.063]) circle(r = 10);
      polygon([[27.219, 48.116], [64.781, 43.884], [63.997, 36.928], [26.435, 41.16]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 24) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 6);
      translate([10.236, 1.153]) circle(r = 6);
    }
    hull() {
      translate([10.236, 1.153]) circle(r = 6);
      translate([19.959, 4.555]) circle(r = 6);
    }
    hull() {
      translate([19.959, 4.555]) circle(r = 6);
      translate([28.681, 10.036]) circle(r = 6);
    }
    hull() {
      translate([28.681, 10.036]) circle(r = 6);
      translate([35.964, 17.319]) circle(r = 6);
    }
    hull() {
      translate([35.964, 17.319]) circle(r = 6);
      translate([41.445, 26.041]) circle(r = 6);
    }
    hull() {
      translate([41.445, 26.041]) circle(r = 6);
      translate([44.847, 35.764]) circle(r = 6);
    }
    hull() {
      translate([44.847, 35.764]) circle(r = 6);
      translate([46.56, 50.969]) circle(r = 6);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([46, 46]) rotate([0, 0, 173.57]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([46, 46]) rotate([0, 0, 173.57]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
