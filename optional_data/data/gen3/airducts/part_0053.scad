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
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 21.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[2.383, -5.248], [-50.383, 5.248], [-49.213, 11.133], [3.554, 0.637]]);
      translate([-22.244, 8.827]) circle(r = 17);
    }
    hull() {
      translate([-22.244, 8.827]) circle(r = 17);
      translate([-19.889, 20.665]) circle(r = 17);
    }
    hull() {
      translate([-19.889, 20.665]) circle(r = 17);
      translate([-8.184, 38.184]) circle(r = 17);
    }
    hull() {
      translate([-8.184, 38.184]) circle(r = 17);
      translate([9.335, 49.889]) circle(r = 17);
    }
    hull() {
      translate([9.335, 49.889]) circle(r = 17);
      translate([30, 54]) circle(r = 17);
    }
    hull() {
      translate([30, 54]) circle(r = 17);
      translate([104.665, 58.111]) circle(r = 17);
    }
    hull() {
      translate([104.665, 58.111]) circle(r = 17);
      translate([122.184, 69.816]) circle(r = 17);
    }
    hull() {
      translate([122.184, 69.816]) circle(r = 17);
      translate([133.889, 87.335]) circle(r = 17);
    }
    hull() {
      translate([133.889, 87.335]) circle(r = 17);
      translate([136.244, 99.173]) circle(r = 17);
    }
    hull() {
      translate([136.244, 99.173]) circle(r = 17);
      polygon([[111.617, 113.248], [164.383, 102.752], [163.213, 96.867], [110.446, 107.363]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 36) {
    hull() {
      translate([-24.975, -4.904]) circle(r = 13);
      translate([-19.889, 20.665]) circle(r = 13);
    }
    hull() {
      translate([-19.889, 20.665]) circle(r = 13);
      translate([-8.184, 38.184]) circle(r = 13);
    }
    hull() {
      translate([-8.184, 38.184]) circle(r = 13);
      translate([9.335, 49.889]) circle(r = 13);
    }
    hull() {
      translate([9.335, 49.889]) circle(r = 13);
      translate([30, 54]) circle(r = 13);
    }
    hull() {
      translate([30, 54]) circle(r = 13);
      translate([104.665, 58.111]) circle(r = 13);
    }
    hull() {
      translate([104.665, 58.111]) circle(r = 13);
      translate([122.184, 69.816]) circle(r = 13);
    }
    hull() {
      translate([122.184, 69.816]) circle(r = 13);
      translate([133.889, 87.335]) circle(r = 13);
    }
    hull() {
      translate([133.889, 87.335]) circle(r = 13);
      translate([138.975, 112.904]) circle(r = 13);
    }
  }
  translate([-24, 0]) rotate([0, 0, -11.25]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([-24, 0]) rotate([0, 0, -11.25]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([138, 108]) rotate([0, 0, 168.75]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([138, 108]) rotate([0, 0, 168.75]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
