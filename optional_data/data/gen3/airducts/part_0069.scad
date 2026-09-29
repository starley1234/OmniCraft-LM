$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 2.5 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 22.9;            // port flange half width
port_d = 45.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 18.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[8.46, -4.468], [-36.46, 4.468], [-34.899, 12.314], [10.021, 3.379]]);
      translate([-11.854, 10.789]) circle(r = 14);
    }
    hull() {
      translate([-11.854, 10.789]) circle(r = 14);
      translate([-9.889, 20.665]) circle(r = 14);
    }
    hull() {
      translate([-9.889, 20.665]) circle(r = 14);
      translate([1.816, 38.184]) circle(r = 14);
    }
    hull() {
      translate([1.816, 38.184]) circle(r = 14);
      translate([19.335, 49.889]) circle(r = 14);
    }
    hull() {
      translate([19.335, 49.889]) circle(r = 14);
      translate([40, 54]) circle(r = 14);
    }
    hull() {
      translate([40, 54]) circle(r = 14);
      translate([114.665, 58.111]) circle(r = 14);
    }
    hull() {
      translate([114.665, 58.111]) circle(r = 14);
      translate([132.184, 69.816]) circle(r = 14);
    }
    hull() {
      translate([132.184, 69.816]) circle(r = 14);
      translate([143.889, 87.335]) circle(r = 14);
    }
    hull() {
      translate([143.889, 87.335]) circle(r = 14);
      translate([145.854, 97.211]) circle(r = 14);
    }
    hull() {
      translate([145.854, 97.211]) circle(r = 14);
      polygon([[125.54, 112.468], [170.46, 103.532], [168.899, 95.686], [123.979, 104.621]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 39) {
    hull() {
      translate([-14.975, -4.904]) circle(r = 11.5);
      translate([-9.889, 20.665]) circle(r = 11.5);
    }
    hull() {
      translate([-9.889, 20.665]) circle(r = 11.5);
      translate([1.816, 38.184]) circle(r = 11.5);
    }
    hull() {
      translate([1.816, 38.184]) circle(r = 11.5);
      translate([19.335, 49.889]) circle(r = 11.5);
    }
    hull() {
      translate([19.335, 49.889]) circle(r = 11.5);
      translate([40, 54]) circle(r = 11.5);
    }
    hull() {
      translate([40, 54]) circle(r = 11.5);
      translate([114.665, 58.111]) circle(r = 11.5);
    }
    hull() {
      translate([114.665, 58.111]) circle(r = 11.5);
      translate([132.184, 69.816]) circle(r = 11.5);
    }
    hull() {
      translate([132.184, 69.816]) circle(r = 11.5);
      translate([143.889, 87.335]) circle(r = 11.5);
    }
    hull() {
      translate([143.889, 87.335]) circle(r = 11.5);
      translate([148.975, 112.904]) circle(r = 11.5);
    }
  }
  translate([-14, 0]) rotate([0, 0, -11.25]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([-14, 0]) rotate([0, 0, -11.25]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([148, 108]) rotate([0, 0, 168.75]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([148, 108]) rotate([0, 0, 168.75]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
}
