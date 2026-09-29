$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 3 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 3;                 // duct wall thickness
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
      translate([12.016, 1.354]) circle(r = 17);
    }
    hull() {
      translate([12.016, 1.354]) circle(r = 17);
      translate([23.43, 5.348]) circle(r = 17);
    }
    hull() {
      translate([23.43, 5.348]) circle(r = 17);
      translate([33.668, 11.781]) circle(r = 17);
    }
    hull() {
      translate([33.668, 11.781]) circle(r = 17);
      translate([42.219, 20.332]) circle(r = 17);
    }
    hull() {
      translate([42.219, 20.332]) circle(r = 17);
      translate([48.652, 30.57]) circle(r = 17);
    }
    hull() {
      translate([48.652, 30.57]) circle(r = 17);
      translate([52.646, 41.984]) circle(r = 17);
    }
    hull() {
      translate([52.646, 41.984]) circle(r = 17);
      translate([52.88, 44.063]) circle(r = 17);
    }
    hull() {
      translate([52.88, 44.063]) circle(r = 17);
      polygon([[27.269, 57.012], [80.731, 50.988], [79.947, 44.032], [26.485, 50.056]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 38) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 14);
      translate([12.016, 1.354]) circle(r = 14);
    }
    hull() {
      translate([12.016, 1.354]) circle(r = 14);
      translate([23.43, 5.348]) circle(r = 14);
    }
    hull() {
      translate([23.43, 5.348]) circle(r = 14);
      translate([33.668, 11.781]) circle(r = 14);
    }
    hull() {
      translate([33.668, 11.781]) circle(r = 14);
      translate([42.219, 20.332]) circle(r = 14);
    }
    hull() {
      translate([42.219, 20.332]) circle(r = 14);
      translate([48.652, 30.57]) circle(r = 14);
    }
    hull() {
      translate([48.652, 30.57]) circle(r = 14);
      translate([52.646, 41.984]) circle(r = 14);
    }
    hull() {
      translate([52.646, 41.984]) circle(r = 14);
      translate([54.56, 58.969]) circle(r = 14);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([54, 54]) rotate([0, 0, 173.57]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
}
