$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 4 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 25.9;            // port flange half width
port_d = 51.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 21.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[2.9, -25.737], [-2.9, 25.737], [4.056, 26.521], [9.856, -24.953]]);
      translate([9.937, 1.12]) circle(r = 17);
    }
    hull() {
      translate([9.937, 1.12]) circle(r = 17);
      translate([10.236, 1.153]) circle(r = 17);
    }
    hull() {
      translate([10.236, 1.153]) circle(r = 17);
      translate([19.959, 4.555]) circle(r = 17);
    }
    hull() {
      translate([19.959, 4.555]) circle(r = 17);
      translate([28.681, 10.036]) circle(r = 17);
    }
    hull() {
      translate([28.681, 10.036]) circle(r = 17);
      translate([35.964, 17.319]) circle(r = 17);
    }
    hull() {
      translate([35.964, 17.319]) circle(r = 17);
      translate([41.445, 26.041]) circle(r = 17);
    }
    hull() {
      translate([41.445, 26.041]) circle(r = 17);
      translate([44.847, 35.764]) circle(r = 17);
    }
    hull() {
      translate([44.847, 35.764]) circle(r = 17);
      translate([44.88, 36.063]) circle(r = 17);
    }
    hull() {
      translate([44.88, 36.063]) circle(r = 17);
      polygon([[20.263, 48.9], [71.737, 43.1], [70.953, 36.144], [19.479, 41.944]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 24) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 13);
      translate([10.236, 1.153]) circle(r = 13);
    }
    hull() {
      translate([10.236, 1.153]) circle(r = 13);
      translate([19.959, 4.555]) circle(r = 13);
    }
    hull() {
      translate([19.959, 4.555]) circle(r = 13);
      translate([28.681, 10.036]) circle(r = 13);
    }
    hull() {
      translate([28.681, 10.036]) circle(r = 13);
      translate([35.964, 17.319]) circle(r = 13);
    }
    hull() {
      translate([35.964, 17.319]) circle(r = 13);
      translate([41.445, 26.041]) circle(r = 13);
    }
    hull() {
      translate([41.445, 26.041]) circle(r = 13);
      translate([44.847, 35.764]) circle(r = 13);
    }
    hull() {
      translate([44.847, 35.764]) circle(r = 13);
      translate([46.56, 50.969]) circle(r = 13);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([46, 46]) rotate([0, 0, 173.57]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([46, 46]) rotate([0, 0, 173.57]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
