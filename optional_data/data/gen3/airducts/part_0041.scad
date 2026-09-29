$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 3.5 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 3.5;               // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 22.9;            // port flange half width
port_d = 45.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 18.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[14.46, -4.468], [-30.46, 4.468], [-29.289, 10.352], [15.631, 1.417]]);
      translate([-6.244, 8.827]) circle(r = 14);
    }
    hull() {
      translate([-6.244, 8.827]) circle(r = 14);
      translate([-5.107, 14.542]) circle(r = 14);
    }
    hull() {
      translate([-5.107, 14.542]) circle(r = 14);
      translate([3.13, 26.87]) circle(r = 14);
    }
    hull() {
      translate([3.13, 26.87]) circle(r = 14);
      translate([15.458, 35.107]) circle(r = 14);
    }
    hull() {
      translate([15.458, 35.107]) circle(r = 14);
      translate([30, 38]) circle(r = 14);
    }
    hull() {
      translate([30, 38]) circle(r = 14);
      translate([82.542, 40.893]) circle(r = 14);
    }
    hull() {
      translate([82.542, 40.893]) circle(r = 14);
      translate([94.87, 49.13]) circle(r = 14);
    }
    hull() {
      translate([94.87, 49.13]) circle(r = 14);
      translate([103.107, 61.458]) circle(r = 14);
    }
    hull() {
      translate([103.107, 61.458]) circle(r = 14);
      translate([104.244, 67.173]) circle(r = 14);
    }
    hull() {
      translate([104.244, 67.173]) circle(r = 14);
      polygon([[83.54, 80.468], [128.46, 71.532], [127.289, 65.648], [82.369, 74.583]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3.5]) linear_extrude(height = 31) {
    hull() {
      translate([-8.975, -4.904]) circle(r = 10.5);
      translate([-5.107, 14.542]) circle(r = 10.5);
    }
    hull() {
      translate([-5.107, 14.542]) circle(r = 10.5);
      translate([3.13, 26.87]) circle(r = 10.5);
    }
    hull() {
      translate([3.13, 26.87]) circle(r = 10.5);
      translate([15.458, 35.107]) circle(r = 10.5);
    }
    hull() {
      translate([15.458, 35.107]) circle(r = 10.5);
      translate([30, 38]) circle(r = 10.5);
    }
    hull() {
      translate([30, 38]) circle(r = 10.5);
      translate([82.542, 40.893]) circle(r = 10.5);
    }
    hull() {
      translate([82.542, 40.893]) circle(r = 10.5);
      translate([94.87, 49.13]) circle(r = 10.5);
    }
    hull() {
      translate([94.87, 49.13]) circle(r = 10.5);
      translate([103.107, 61.458]) circle(r = 10.5);
    }
    hull() {
      translate([103.107, 61.458]) circle(r = 10.5);
      translate([106.975, 80.904]) circle(r = 10.5);
    }
  }
  translate([-8, 0]) rotate([0, 0, -11.25]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([-8, 0]) rotate([0, 0, -11.25]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([106, 76]) rotate([0, 0, 168.75]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([106, 76]) rotate([0, 0, 168.75]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
}
