$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 3.5 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 19.9;            // port flange half width
port_d = 39.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 14.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[23.518, -3.882], [-15.518, 3.882], [-14.152, 10.748], [24.883, 2.983]]);
      translate([5.951, 9.808]) circle(r = 10);
    }
    hull() {
      translate([5.951, 9.808]) circle(r = 10);
      translate([7.502, 17.603]) circle(r = 10);
    }
    hull() {
      translate([7.502, 17.603]) circle(r = 10);
      translate([17.473, 32.527]) circle(r = 10);
    }
    hull() {
      translate([17.473, 32.527]) circle(r = 10);
      translate([32.397, 42.498]) circle(r = 10);
    }
    hull() {
      translate([32.397, 42.498]) circle(r = 10);
      translate([50, 46]) circle(r = 10);
    }
    hull() {
      translate([50, 46]) circle(r = 10);
      translate([113.603, 49.502]) circle(r = 10);
    }
    hull() {
      translate([113.603, 49.502]) circle(r = 10);
      translate([128.527, 59.473]) circle(r = 10);
    }
    hull() {
      translate([128.527, 59.473]) circle(r = 10);
      translate([138.498, 74.397]) circle(r = 10);
    }
    hull() {
      translate([138.498, 74.397]) circle(r = 10);
      translate([140.049, 82.192]) circle(r = 10);
    }
    hull() {
      translate([140.049, 82.192]) circle(r = 10);
      polygon([[122.482, 95.882], [161.518, 88.118], [160.152, 81.252], [121.117, 89.017]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 19) {
    hull() {
      translate([3.025, -4.904]) circle(r = 6.5);
      translate([7.502, 17.603]) circle(r = 6.5);
    }
    hull() {
      translate([7.502, 17.603]) circle(r = 6.5);
      translate([17.473, 32.527]) circle(r = 6.5);
    }
    hull() {
      translate([17.473, 32.527]) circle(r = 6.5);
      translate([32.397, 42.498]) circle(r = 6.5);
    }
    hull() {
      translate([32.397, 42.498]) circle(r = 6.5);
      translate([50, 46]) circle(r = 6.5);
    }
    hull() {
      translate([50, 46]) circle(r = 6.5);
      translate([113.603, 49.502]) circle(r = 6.5);
    }
    hull() {
      translate([113.603, 49.502]) circle(r = 6.5);
      translate([128.527, 59.473]) circle(r = 6.5);
    }
    hull() {
      translate([128.527, 59.473]) circle(r = 6.5);
      translate([138.498, 74.397]) circle(r = 6.5);
    }
    hull() {
      translate([138.498, 74.397]) circle(r = 6.5);
      translate([142.975, 96.904]) circle(r = 6.5);
    }
  }
  translate([4, 0]) rotate([0, 0, -11.25]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([4, 0]) rotate([0, 0, -11.25]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([142, 92]) rotate([0, 0, 168.75]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([142, 92]) rotate([0, 0, 168.75]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
}
