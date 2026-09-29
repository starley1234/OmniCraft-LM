$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 2.5 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 22.9;            // port flange half width
port_d = 45.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 18.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[2.564, -22.756], [-2.564, 22.756], [3.398, 23.428], [8.526, -22.084]]);
      translate([8.943, 1.008]) circle(r = 14);
    }
    hull() {
      translate([8.943, 1.008]) circle(r = 14);
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
      translate([44.992, 37.057]) circle(r = 14);
    }
    hull() {
      translate([44.992, 37.057]) circle(r = 14);
      polygon([[23.244, 48.564], [68.756, 43.436], [68.084, 37.474], [22.572, 42.602]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 27) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 11.5);
      translate([10.236, 1.153]) circle(r = 11.5);
    }
    hull() {
      translate([10.236, 1.153]) circle(r = 11.5);
      translate([19.959, 4.555]) circle(r = 11.5);
    }
    hull() {
      translate([19.959, 4.555]) circle(r = 11.5);
      translate([28.681, 10.036]) circle(r = 11.5);
    }
    hull() {
      translate([28.681, 10.036]) circle(r = 11.5);
      translate([35.964, 17.319]) circle(r = 11.5);
    }
    hull() {
      translate([35.964, 17.319]) circle(r = 11.5);
      translate([41.445, 26.041]) circle(r = 11.5);
    }
    hull() {
      translate([41.445, 26.041]) circle(r = 11.5);
      translate([44.847, 35.764]) circle(r = 11.5);
    }
    hull() {
      translate([44.847, 35.764]) circle(r = 11.5);
      translate([46.56, 50.969]) circle(r = 11.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([46, 46]) rotate([0, 0, 173.57]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([46, 46]) rotate([0, 0, 173.57]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
}
