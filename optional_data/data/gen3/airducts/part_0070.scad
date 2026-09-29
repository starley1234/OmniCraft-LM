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
port_t = 8;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 18.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[42.46, -4.468], [-2.46, 4.468], [-0.899, 12.314], [44.021, 3.379]]);
      translate([22.146, 10.789]) circle(r = 14);
    }
    hull() {
      translate([22.146, 10.789]) circle(r = 14);
      translate([22.284, 11.481]) circle(r = 14);
    }
    hull() {
      translate([22.284, 11.481]) circle(r = 14);
      translate([28.787, 21.213]) circle(r = 14);
    }
    hull() {
      translate([28.787, 21.213]) circle(r = 14);
      translate([38.519, 27.716]) circle(r = 14);
    }
    hull() {
      translate([38.519, 27.716]) circle(r = 14);
      translate([50, 30]) circle(r = 14);
    }
    hull() {
      translate([50, 30]) circle(r = 14);
      translate([91.481, 32.284]) circle(r = 14);
    }
    hull() {
      translate([91.481, 32.284]) circle(r = 14);
      translate([101.213, 38.787]) circle(r = 14);
    }
    hull() {
      translate([101.213, 38.787]) circle(r = 14);
      translate([107.716, 48.519]) circle(r = 14);
    }
    hull() {
      translate([107.716, 48.519]) circle(r = 14);
      translate([107.854, 49.211]) circle(r = 14);
    }
    hull() {
      translate([107.854, 49.211]) circle(r = 14);
      polygon([[87.54, 64.468], [132.46, 55.532], [130.899, 47.686], [85.979, 56.621]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 27) {
    hull() {
      translate([19.025, -4.904]) circle(r = 11.5);
      translate([22.284, 11.481]) circle(r = 11.5);
    }
    hull() {
      translate([22.284, 11.481]) circle(r = 11.5);
      translate([28.787, 21.213]) circle(r = 11.5);
    }
    hull() {
      translate([28.787, 21.213]) circle(r = 11.5);
      translate([38.519, 27.716]) circle(r = 11.5);
    }
    hull() {
      translate([38.519, 27.716]) circle(r = 11.5);
      translate([50, 30]) circle(r = 11.5);
    }
    hull() {
      translate([50, 30]) circle(r = 11.5);
      translate([91.481, 32.284]) circle(r = 11.5);
    }
    hull() {
      translate([91.481, 32.284]) circle(r = 11.5);
      translate([101.213, 38.787]) circle(r = 11.5);
    }
    hull() {
      translate([101.213, 38.787]) circle(r = 11.5);
      translate([107.716, 48.519]) circle(r = 11.5);
    }
    hull() {
      translate([107.716, 48.519]) circle(r = 11.5);
      translate([110.975, 64.904]) circle(r = 11.5);
    }
  }
  translate([20, 0]) rotate([0, 0, -11.25]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([20, 0]) rotate([0, 0, -11.25]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([110, 60]) rotate([0, 0, 168.75]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([110, 60]) rotate([0, 0, 168.75]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
}
