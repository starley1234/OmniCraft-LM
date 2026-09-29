$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 2.5 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 20.9;            // port flange half width
port_d = 41.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 16.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[40.498, -4.077], [-0.498, 4.077], [0.867, 10.943], [41.864, 2.788]]);
      translate([21.951, 9.808]) circle(r = 12);
    }
    hull() {
      translate([21.951, 9.808]) circle(r = 12);
      translate([22.284, 11.481]) circle(r = 12);
    }
    hull() {
      translate([22.284, 11.481]) circle(r = 12);
      translate([28.787, 21.213]) circle(r = 12);
    }
    hull() {
      translate([28.787, 21.213]) circle(r = 12);
      translate([38.519, 27.716]) circle(r = 12);
    }
    hull() {
      translate([38.519, 27.716]) circle(r = 12);
      translate([50, 30]) circle(r = 12);
    }
    hull() {
      translate([50, 30]) circle(r = 12);
      translate([91.481, 32.284]) circle(r = 12);
    }
    hull() {
      translate([91.481, 32.284]) circle(r = 12);
      translate([101.213, 38.787]) circle(r = 12);
    }
    hull() {
      translate([101.213, 38.787]) circle(r = 12);
      translate([107.716, 48.519]) circle(r = 12);
    }
    hull() {
      translate([107.716, 48.519]) circle(r = 12);
      translate([108.049, 50.192]) circle(r = 12);
    }
    hull() {
      translate([108.049, 50.192]) circle(r = 12);
      polygon([[89.502, 64.077], [130.498, 55.923], [129.133, 49.057], [88.136, 57.212]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 21) {
    hull() {
      translate([19.025, -4.904]) circle(r = 9.5);
      translate([22.284, 11.481]) circle(r = 9.5);
    }
    hull() {
      translate([22.284, 11.481]) circle(r = 9.5);
      translate([28.787, 21.213]) circle(r = 9.5);
    }
    hull() {
      translate([28.787, 21.213]) circle(r = 9.5);
      translate([38.519, 27.716]) circle(r = 9.5);
    }
    hull() {
      translate([38.519, 27.716]) circle(r = 9.5);
      translate([50, 30]) circle(r = 9.5);
    }
    hull() {
      translate([50, 30]) circle(r = 9.5);
      translate([91.481, 32.284]) circle(r = 9.5);
    }
    hull() {
      translate([91.481, 32.284]) circle(r = 9.5);
      translate([101.213, 38.787]) circle(r = 9.5);
    }
    hull() {
      translate([101.213, 38.787]) circle(r = 9.5);
      translate([107.716, 48.519]) circle(r = 9.5);
    }
    hull() {
      translate([107.716, 48.519]) circle(r = 9.5);
      translate([110.975, 64.904]) circle(r = 9.5);
    }
  }
  translate([20, 0]) rotate([0, 0, -11.25]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([20, 0]) rotate([0, 0, -11.25]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([110, 60]) rotate([0, 0, 168.75]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([110, 60]) rotate([0, 0, 168.75]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
