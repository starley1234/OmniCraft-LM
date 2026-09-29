$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 28 mm duct, 4 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 14;              // duct core radius
duct_d = 28;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 22.9;            // port flange half width
port_d = 45.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 18.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[24.46, -4.468], [-20.46, 4.468], [-19.289, 10.352], [25.631, 1.417]]);
      translate([3.756, 8.827]) circle(r = 14);
    }
    hull() {
      translate([3.756, 8.827]) circle(r = 14);
      translate([4.893, 14.542]) circle(r = 14);
    }
    hull() {
      translate([4.893, 14.542]) circle(r = 14);
      translate([13.13, 26.87]) circle(r = 14);
    }
    hull() {
      translate([13.13, 26.87]) circle(r = 14);
      translate([25.458, 35.107]) circle(r = 14);
    }
    hull() {
      translate([25.458, 35.107]) circle(r = 14);
      translate([40, 38]) circle(r = 14);
    }
    hull() {
      translate([40, 38]) circle(r = 14);
      translate([92.542, 40.893]) circle(r = 14);
    }
    hull() {
      translate([92.542, 40.893]) circle(r = 14);
      translate([104.87, 49.13]) circle(r = 14);
    }
    hull() {
      translate([104.87, 49.13]) circle(r = 14);
      translate([113.107, 61.458]) circle(r = 14);
    }
    hull() {
      translate([113.107, 61.458]) circle(r = 14);
      translate([114.244, 67.173]) circle(r = 14);
    }
    hull() {
      translate([114.244, 67.173]) circle(r = 14);
      polygon([[93.54, 80.468], [138.46, 71.532], [137.289, 65.648], [92.369, 74.583]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 18) {
    hull() {
      translate([1.025, -4.904]) circle(r = 10);
      translate([4.893, 14.542]) circle(r = 10);
    }
    hull() {
      translate([4.893, 14.542]) circle(r = 10);
      translate([13.13, 26.87]) circle(r = 10);
    }
    hull() {
      translate([13.13, 26.87]) circle(r = 10);
      translate([25.458, 35.107]) circle(r = 10);
    }
    hull() {
      translate([25.458, 35.107]) circle(r = 10);
      translate([40, 38]) circle(r = 10);
    }
    hull() {
      translate([40, 38]) circle(r = 10);
      translate([92.542, 40.893]) circle(r = 10);
    }
    hull() {
      translate([92.542, 40.893]) circle(r = 10);
      translate([104.87, 49.13]) circle(r = 10);
    }
    hull() {
      translate([104.87, 49.13]) circle(r = 10);
      translate([113.107, 61.458]) circle(r = 10);
    }
    hull() {
      translate([113.107, 61.458]) circle(r = 10);
      translate([116.975, 80.904]) circle(r = 10);
    }
  }
  translate([2, 0]) rotate([0, 0, -11.25]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([2, 0]) rotate([0, 0, -11.25]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([116, 76]) rotate([0, 0, 168.75]) translate([-18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
  translate([116, 76]) rotate([0, 0, 168.75]) translate([18.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 4.4);
}
