$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 4 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 19.9;            // port flange half width
port_d = 39.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 14.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[5.518, -3.882], [-33.518, 3.882], [-31.957, 11.729], [7.078, 3.964]]);
      translate([-11.854, 10.789]) circle(r = 10);
    }
    hull() {
      translate([-11.854, 10.789]) circle(r = 10);
      translate([-9.889, 20.665]) circle(r = 10);
    }
    hull() {
      translate([-9.889, 20.665]) circle(r = 10);
      translate([1.816, 38.184]) circle(r = 10);
    }
    hull() {
      translate([1.816, 38.184]) circle(r = 10);
      translate([19.335, 49.889]) circle(r = 10);
    }
    hull() {
      translate([19.335, 49.889]) circle(r = 10);
      translate([40, 54]) circle(r = 10);
    }
    hull() {
      translate([40, 54]) circle(r = 10);
      translate([114.665, 58.111]) circle(r = 10);
    }
    hull() {
      translate([114.665, 58.111]) circle(r = 10);
      translate([132.184, 69.816]) circle(r = 10);
    }
    hull() {
      translate([132.184, 69.816]) circle(r = 10);
      translate([143.889, 87.335]) circle(r = 10);
    }
    hull() {
      translate([143.889, 87.335]) circle(r = 10);
      translate([145.854, 97.211]) circle(r = 10);
    }
    hull() {
      translate([145.854, 97.211]) circle(r = 10);
      polygon([[128.482, 111.882], [167.518, 104.118], [165.957, 96.271], [126.922, 104.036]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 18) {
    hull() {
      translate([-14.975, -4.904]) circle(r = 6);
      translate([-9.889, 20.665]) circle(r = 6);
    }
    hull() {
      translate([-9.889, 20.665]) circle(r = 6);
      translate([1.816, 38.184]) circle(r = 6);
    }
    hull() {
      translate([1.816, 38.184]) circle(r = 6);
      translate([19.335, 49.889]) circle(r = 6);
    }
    hull() {
      translate([19.335, 49.889]) circle(r = 6);
      translate([40, 54]) circle(r = 6);
    }
    hull() {
      translate([40, 54]) circle(r = 6);
      translate([114.665, 58.111]) circle(r = 6);
    }
    hull() {
      translate([114.665, 58.111]) circle(r = 6);
      translate([132.184, 69.816]) circle(r = 6);
    }
    hull() {
      translate([132.184, 69.816]) circle(r = 6);
      translate([143.889, 87.335]) circle(r = 6);
    }
    hull() {
      translate([143.889, 87.335]) circle(r = 6);
      translate([148.975, 112.904]) circle(r = 6);
    }
  }
  translate([-14, 0]) rotate([0, 0, -11.25]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([-14, 0]) rotate([0, 0, -11.25]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([148, 108]) rotate([0, 0, 168.75]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([148, 108]) rotate([0, 0, 168.75]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
