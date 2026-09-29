$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 3 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 25.9;            // port flange half width
port_d = 51.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 21.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[45.402, -5.053], [-5.402, 5.053], [-4.037, 11.918], [46.768, 1.813]]);
      translate([21.951, 9.808]) circle(r = 17);
    }
    hull() {
      translate([21.951, 9.808]) circle(r = 17);
      translate([22.284, 11.481]) circle(r = 17);
    }
    hull() {
      translate([22.284, 11.481]) circle(r = 17);
      translate([28.787, 21.213]) circle(r = 17);
    }
    hull() {
      translate([28.787, 21.213]) circle(r = 17);
      translate([38.519, 27.716]) circle(r = 17);
    }
    hull() {
      translate([38.519, 27.716]) circle(r = 17);
      translate([50, 30]) circle(r = 17);
    }
    hull() {
      translate([50, 30]) circle(r = 17);
      translate([91.481, 32.284]) circle(r = 17);
    }
    hull() {
      translate([91.481, 32.284]) circle(r = 17);
      translate([101.213, 38.787]) circle(r = 17);
    }
    hull() {
      translate([101.213, 38.787]) circle(r = 17);
      translate([107.716, 48.519]) circle(r = 17);
    }
    hull() {
      translate([107.716, 48.519]) circle(r = 17);
      translate([108.049, 50.192]) circle(r = 17);
    }
    hull() {
      translate([108.049, 50.192]) circle(r = 17);
      polygon([[84.598, 65.053], [135.402, 54.947], [134.037, 48.082], [83.232, 58.187]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 32) {
    hull() {
      translate([19.025, -4.904]) circle(r = 14);
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
      translate([110.975, 64.904]) circle(r = 14);
    }
  }
  translate([20, 0]) rotate([0, 0, -11.25]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([20, 0]) rotate([0, 0, -11.25]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([110, 60]) rotate([0, 0, 168.75]) translate([-21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([110, 60]) rotate([0, 0, 168.75]) translate([21.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
