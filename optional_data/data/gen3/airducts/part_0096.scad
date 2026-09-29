$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 4 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 4;                 // duct wall thickness
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
      polygon([[30.498, -4.077], [-10.498, 4.077], [-9.133, 10.943], [31.864, 2.788]]);
      translate([11.951, 9.808]) circle(r = 12);
    }
    hull() {
      translate([11.951, 9.808]) circle(r = 12);
      translate([12.284, 11.481]) circle(r = 12);
    }
    hull() {
      translate([12.284, 11.481]) circle(r = 12);
      translate([18.787, 21.213]) circle(r = 12);
    }
    hull() {
      translate([18.787, 21.213]) circle(r = 12);
      translate([28.519, 27.716]) circle(r = 12);
    }
    hull() {
      translate([28.519, 27.716]) circle(r = 12);
      translate([40, 30]) circle(r = 12);
    }
    hull() {
      translate([40, 30]) circle(r = 12);
      translate([81.481, 32.284]) circle(r = 12);
    }
    hull() {
      translate([81.481, 32.284]) circle(r = 12);
      translate([91.213, 38.787]) circle(r = 12);
    }
    hull() {
      translate([91.213, 38.787]) circle(r = 12);
      translate([97.716, 48.519]) circle(r = 12);
    }
    hull() {
      translate([97.716, 48.519]) circle(r = 12);
      translate([98.049, 50.192]) circle(r = 12);
    }
    hull() {
      translate([98.049, 50.192]) circle(r = 12);
      polygon([[79.502, 64.077], [120.498, 55.923], [119.133, 49.057], [78.136, 57.212]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 18) {
    hull() {
      translate([9.025, -4.904]) circle(r = 8);
      translate([12.284, 11.481]) circle(r = 8);
    }
    hull() {
      translate([12.284, 11.481]) circle(r = 8);
      translate([18.787, 21.213]) circle(r = 8);
    }
    hull() {
      translate([18.787, 21.213]) circle(r = 8);
      translate([28.519, 27.716]) circle(r = 8);
    }
    hull() {
      translate([28.519, 27.716]) circle(r = 8);
      translate([40, 30]) circle(r = 8);
    }
    hull() {
      translate([40, 30]) circle(r = 8);
      translate([81.481, 32.284]) circle(r = 8);
    }
    hull() {
      translate([81.481, 32.284]) circle(r = 8);
      translate([91.213, 38.787]) circle(r = 8);
    }
    hull() {
      translate([91.213, 38.787]) circle(r = 8);
      translate([97.716, 48.519]) circle(r = 8);
    }
    hull() {
      translate([97.716, 48.519]) circle(r = 8);
      translate([100.975, 64.904]) circle(r = 8);
    }
  }
  translate([10, 0]) rotate([0, 0, -11.25]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([10, 0]) rotate([0, 0, -11.25]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([100, 60]) rotate([0, 0, 168.75]) translate([-16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([100, 60]) rotate([0, 0, 168.75]) translate([16.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
