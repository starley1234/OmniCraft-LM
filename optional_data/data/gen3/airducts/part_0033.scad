$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 3.5 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 19.9;            // port flange half width
port_d = 39.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 14.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[-4.482, -3.882], [-43.518, 3.882], [-41.957, 11.729], [-2.922, 3.964]]);
      translate([-21.854, 10.789]) circle(r = 10);
    }
    hull() {
      translate([-21.854, 10.789]) circle(r = 10);
      translate([-19.889, 20.665]) circle(r = 10);
    }
    hull() {
      translate([-19.889, 20.665]) circle(r = 10);
      translate([-8.184, 38.184]) circle(r = 10);
    }
    hull() {
      translate([-8.184, 38.184]) circle(r = 10);
      translate([9.335, 49.889]) circle(r = 10);
    }
    hull() {
      translate([9.335, 49.889]) circle(r = 10);
      translate([30, 54]) circle(r = 10);
    }
    hull() {
      translate([30, 54]) circle(r = 10);
      translate([104.665, 58.111]) circle(r = 10);
    }
    hull() {
      translate([104.665, 58.111]) circle(r = 10);
      translate([122.184, 69.816]) circle(r = 10);
    }
    hull() {
      translate([122.184, 69.816]) circle(r = 10);
      translate([133.889, 87.335]) circle(r = 10);
    }
    hull() {
      translate([133.889, 87.335]) circle(r = 10);
      translate([135.854, 97.211]) circle(r = 10);
    }
    hull() {
      translate([135.854, 97.211]) circle(r = 10);
      polygon([[118.482, 111.882], [157.518, 104.118], [155.957, 96.271], [116.922, 104.036]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 31) {
    hull() {
      translate([-24.975, -4.904]) circle(r = 6.5);
      translate([-19.889, 20.665]) circle(r = 6.5);
    }
    hull() {
      translate([-19.889, 20.665]) circle(r = 6.5);
      translate([-8.184, 38.184]) circle(r = 6.5);
    }
    hull() {
      translate([-8.184, 38.184]) circle(r = 6.5);
      translate([9.335, 49.889]) circle(r = 6.5);
    }
    hull() {
      translate([9.335, 49.889]) circle(r = 6.5);
      translate([30, 54]) circle(r = 6.5);
    }
    hull() {
      translate([30, 54]) circle(r = 6.5);
      translate([104.665, 58.111]) circle(r = 6.5);
    }
    hull() {
      translate([104.665, 58.111]) circle(r = 6.5);
      translate([122.184, 69.816]) circle(r = 6.5);
    }
    hull() {
      translate([122.184, 69.816]) circle(r = 6.5);
      translate([133.889, 87.335]) circle(r = 6.5);
    }
    hull() {
      translate([133.889, 87.335]) circle(r = 6.5);
      translate([138.975, 112.904]) circle(r = 6.5);
    }
  }
  translate([-24, 0]) rotate([0, 0, -11.25]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([-24, 0]) rotate([0, 0, -11.25]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([138, 108]) rotate([0, 0, 168.75]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([138, 108]) rotate([0, 0, 168.75]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
