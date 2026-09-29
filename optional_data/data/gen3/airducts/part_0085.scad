$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 2.5 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 26.9;            // port flange half width
port_d = 53.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 21.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[3.012, -26.731], [-3.012, 26.731], [3.944, 27.515], [9.968, -25.947]]);
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
      polygon([[19.269, 49.012], [72.731, 42.988], [71.947, 36.032], [18.485, 42.056]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 39) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 14.5);
      translate([10.236, 1.153]) circle(r = 14.5);
    }
    hull() {
      translate([10.236, 1.153]) circle(r = 14.5);
      translate([19.959, 4.555]) circle(r = 14.5);
    }
    hull() {
      translate([19.959, 4.555]) circle(r = 14.5);
      translate([28.681, 10.036]) circle(r = 14.5);
    }
    hull() {
      translate([28.681, 10.036]) circle(r = 14.5);
      translate([35.964, 17.319]) circle(r = 14.5);
    }
    hull() {
      translate([35.964, 17.319]) circle(r = 14.5);
      translate([41.445, 26.041]) circle(r = 14.5);
    }
    hull() {
      translate([41.445, 26.041]) circle(r = 14.5);
      translate([44.847, 35.764]) circle(r = 14.5);
    }
    hull() {
      translate([44.847, 35.764]) circle(r = 14.5);
      translate([46.56, 50.969]) circle(r = 14.5);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([46, 46]) rotate([0, 0, 173.57]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([46, 46]) rotate([0, 0, 173.57]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
}
