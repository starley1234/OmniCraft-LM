$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 3.5 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 22.9;            // port flange half width
port_d = 45.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 18.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[32.46, -4.468], [-12.46, 4.468], [-11.094, 11.333], [33.826, 2.398]]);
      translate([11.951, 9.808]) circle(r = 14);
    }
    hull() {
      translate([11.951, 9.808]) circle(r = 14);
      translate([12.284, 11.481]) circle(r = 14);
    }
    hull() {
      translate([12.284, 11.481]) circle(r = 14);
      translate([18.787, 21.213]) circle(r = 14);
    }
    hull() {
      translate([18.787, 21.213]) circle(r = 14);
      translate([28.519, 27.716]) circle(r = 14);
    }
    hull() {
      translate([28.519, 27.716]) circle(r = 14);
      translate([40, 30]) circle(r = 14);
    }
    hull() {
      translate([40, 30]) circle(r = 14);
      translate([81.481, 32.284]) circle(r = 14);
    }
    hull() {
      translate([81.481, 32.284]) circle(r = 14);
      translate([91.213, 38.787]) circle(r = 14);
    }
    hull() {
      translate([91.213, 38.787]) circle(r = 14);
      translate([97.716, 48.519]) circle(r = 14);
    }
    hull() {
      translate([97.716, 48.519]) circle(r = 14);
      translate([98.049, 50.192]) circle(r = 14);
    }
    hull() {
      translate([98.049, 50.192]) circle(r = 14);
      polygon([[77.54, 64.468], [122.46, 55.532], [121.094, 48.667], [76.174, 57.602]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 25) {
    hull() {
      translate([9.025, -4.904]) circle(r = 10.5);
      translate([12.284, 11.481]) circle(r = 10.5);
    }
    hull() {
      translate([12.284, 11.481]) circle(r = 10.5);
      translate([18.787, 21.213]) circle(r = 10.5);
    }
    hull() {
      translate([18.787, 21.213]) circle(r = 10.5);
      translate([28.519, 27.716]) circle(r = 10.5);
    }
    hull() {
      translate([28.519, 27.716]) circle(r = 10.5);
      translate([40, 30]) circle(r = 10.5);
    }
    hull() {
      translate([40, 30]) circle(r = 10.5);
      translate([81.481, 32.284]) circle(r = 10.5);
    }
    hull() {
      translate([81.481, 32.284]) circle(r = 10.5);
      translate([91.213, 38.787]) circle(r = 10.5);
    }
    hull() {
      translate([91.213, 38.787]) circle(r = 10.5);
      translate([97.716, 48.519]) circle(r = 10.5);
    }
    hull() {
      translate([97.716, 48.519]) circle(r = 10.5);
      translate([100.975, 64.904]) circle(r = 10.5);
    }
  }
  translate([10, 0]) rotate([0, 0, -11.25]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([10, 0]) rotate([0, 0, -11.25]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([100, 60]) rotate([0, 0, 168.75]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
  translate([100, 60]) rotate([0, 0, 168.75]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 4.4);
}
