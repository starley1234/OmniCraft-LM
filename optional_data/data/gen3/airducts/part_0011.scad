$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 3.5 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 21.9;            // port flange half width
port_d = 43.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 16.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[17.479, -4.272], [-25.479, 4.272], [-23.918, 12.119], [19.04, 3.574]]);
      translate([-1.854, 10.789]) circle(r = 12);
    }
    hull() {
      translate([-1.854, 10.789]) circle(r = 12);
      translate([0.111, 20.665]) circle(r = 12);
    }
    hull() {
      translate([0.111, 20.665]) circle(r = 12);
      translate([11.816, 38.184]) circle(r = 12);
    }
    hull() {
      translate([11.816, 38.184]) circle(r = 12);
      translate([29.335, 49.889]) circle(r = 12);
    }
    hull() {
      translate([29.335, 49.889]) circle(r = 12);
      translate([50, 54]) circle(r = 12);
    }
    hull() {
      translate([50, 54]) circle(r = 12);
      translate([124.665, 58.111]) circle(r = 12);
    }
    hull() {
      translate([124.665, 58.111]) circle(r = 12);
      translate([142.184, 69.816]) circle(r = 12);
    }
    hull() {
      translate([142.184, 69.816]) circle(r = 12);
      translate([153.889, 87.335]) circle(r = 12);
    }
    hull() {
      translate([153.889, 87.335]) circle(r = 12);
      translate([155.854, 97.211]) circle(r = 12);
    }
    hull() {
      translate([155.854, 97.211]) circle(r = 12);
      polygon([[136.521, 112.272], [179.479, 103.728], [177.918, 95.881], [134.96, 104.426]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 19) {
    hull() {
      translate([-4.975, -4.904]) circle(r = 8.5);
      translate([0.111, 20.665]) circle(r = 8.5);
    }
    hull() {
      translate([0.111, 20.665]) circle(r = 8.5);
      translate([11.816, 38.184]) circle(r = 8.5);
    }
    hull() {
      translate([11.816, 38.184]) circle(r = 8.5);
      translate([29.335, 49.889]) circle(r = 8.5);
    }
    hull() {
      translate([29.335, 49.889]) circle(r = 8.5);
      translate([50, 54]) circle(r = 8.5);
    }
    hull() {
      translate([50, 54]) circle(r = 8.5);
      translate([124.665, 58.111]) circle(r = 8.5);
    }
    hull() {
      translate([124.665, 58.111]) circle(r = 8.5);
      translate([142.184, 69.816]) circle(r = 8.5);
    }
    hull() {
      translate([142.184, 69.816]) circle(r = 8.5);
      translate([153.889, 87.335]) circle(r = 8.5);
    }
    hull() {
      translate([153.889, 87.335]) circle(r = 8.5);
      translate([158.975, 112.904]) circle(r = 8.5);
    }
  }
  translate([-4, 0]) rotate([0, 0, -11.25]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([-4, 0]) rotate([0, 0, -11.25]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([158, 108]) rotate([0, 0, 168.75]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([158, 108]) rotate([0, 0, 168.75]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
