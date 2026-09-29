$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 4 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 26.9;            // port flange half width
port_d = 53.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 21.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[22.383, -5.248], [-30.383, 5.248], [-28.822, 13.094], [23.944, 2.598]]);
      translate([-1.854, 10.789]) circle(r = 17);
    }
    hull() {
      translate([-1.854, 10.789]) circle(r = 17);
      translate([0.111, 20.665]) circle(r = 17);
    }
    hull() {
      translate([0.111, 20.665]) circle(r = 17);
      translate([11.816, 38.184]) circle(r = 17);
    }
    hull() {
      translate([11.816, 38.184]) circle(r = 17);
      translate([29.335, 49.889]) circle(r = 17);
    }
    hull() {
      translate([29.335, 49.889]) circle(r = 17);
      translate([50, 54]) circle(r = 17);
    }
    hull() {
      translate([50, 54]) circle(r = 17);
      translate([124.665, 58.111]) circle(r = 17);
    }
    hull() {
      translate([124.665, 58.111]) circle(r = 17);
      translate([142.184, 69.816]) circle(r = 17);
    }
    hull() {
      translate([142.184, 69.816]) circle(r = 17);
      translate([153.889, 87.335]) circle(r = 17);
    }
    hull() {
      translate([153.889, 87.335]) circle(r = 17);
      translate([155.854, 97.211]) circle(r = 17);
    }
    hull() {
      translate([155.854, 97.211]) circle(r = 17);
      polygon([[131.617, 113.248], [184.383, 102.752], [182.822, 94.906], [130.056, 105.402]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 36) {
    hull() {
      translate([-4.975, -4.904]) circle(r = 13);
      translate([0.111, 20.665]) circle(r = 13);
    }
    hull() {
      translate([0.111, 20.665]) circle(r = 13);
      translate([11.816, 38.184]) circle(r = 13);
    }
    hull() {
      translate([11.816, 38.184]) circle(r = 13);
      translate([29.335, 49.889]) circle(r = 13);
    }
    hull() {
      translate([29.335, 49.889]) circle(r = 13);
      translate([50, 54]) circle(r = 13);
    }
    hull() {
      translate([50, 54]) circle(r = 13);
      translate([124.665, 58.111]) circle(r = 13);
    }
    hull() {
      translate([124.665, 58.111]) circle(r = 13);
      translate([142.184, 69.816]) circle(r = 13);
    }
    hull() {
      translate([142.184, 69.816]) circle(r = 13);
      translate([153.889, 87.335]) circle(r = 13);
    }
    hull() {
      translate([153.889, 87.335]) circle(r = 13);
      translate([158.975, 112.904]) circle(r = 13);
    }
  }
  translate([-4, 0]) rotate([0, 0, -11.25]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([-4, 0]) rotate([0, 0, -11.25]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([158, 108]) rotate([0, 0, 168.75]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([158, 108]) rotate([0, 0, 168.75]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
