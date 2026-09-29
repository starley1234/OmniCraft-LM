$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 3 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 19.9;            // port flange half width
port_d = 39.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 14.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[29.518, -3.882], [-9.518, 3.882], [-8.347, 9.767], [30.688, 2.002]]);
      translate([11.756, 8.827]) circle(r = 10);
    }
    hull() {
      translate([11.756, 8.827]) circle(r = 10);
      translate([12.284, 11.481]) circle(r = 10);
    }
    hull() {
      translate([12.284, 11.481]) circle(r = 10);
      translate([18.787, 21.213]) circle(r = 10);
    }
    hull() {
      translate([18.787, 21.213]) circle(r = 10);
      translate([28.519, 27.716]) circle(r = 10);
    }
    hull() {
      translate([28.519, 27.716]) circle(r = 10);
      translate([40, 30]) circle(r = 10);
    }
    hull() {
      translate([40, 30]) circle(r = 10);
      translate([81.481, 32.284]) circle(r = 10);
    }
    hull() {
      translate([81.481, 32.284]) circle(r = 10);
      translate([91.213, 38.787]) circle(r = 10);
    }
    hull() {
      translate([91.213, 38.787]) circle(r = 10);
      translate([97.716, 48.519]) circle(r = 10);
    }
    hull() {
      translate([97.716, 48.519]) circle(r = 10);
      translate([98.244, 51.173]) circle(r = 10);
    }
    hull() {
      translate([98.244, 51.173]) circle(r = 10);
      polygon([[80.482, 63.882], [119.518, 56.118], [118.347, 50.233], [79.312, 57.998]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 20) {
    hull() {
      translate([9.025, -4.904]) circle(r = 7);
      translate([12.284, 11.481]) circle(r = 7);
    }
    hull() {
      translate([12.284, 11.481]) circle(r = 7);
      translate([18.787, 21.213]) circle(r = 7);
    }
    hull() {
      translate([18.787, 21.213]) circle(r = 7);
      translate([28.519, 27.716]) circle(r = 7);
    }
    hull() {
      translate([28.519, 27.716]) circle(r = 7);
      translate([40, 30]) circle(r = 7);
    }
    hull() {
      translate([40, 30]) circle(r = 7);
      translate([81.481, 32.284]) circle(r = 7);
    }
    hull() {
      translate([81.481, 32.284]) circle(r = 7);
      translate([91.213, 38.787]) circle(r = 7);
    }
    hull() {
      translate([91.213, 38.787]) circle(r = 7);
      translate([97.716, 48.519]) circle(r = 7);
    }
    hull() {
      translate([97.716, 48.519]) circle(r = 7);
      translate([100.975, 64.904]) circle(r = 7);
    }
  }
  translate([10, 0]) rotate([0, 0, -11.25]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([10, 0]) rotate([0, 0, -11.25]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([100, 60]) rotate([0, 0, 168.75]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([100, 60]) rotate([0, 0, 168.75]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
