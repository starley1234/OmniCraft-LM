$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 2.5 mm wall, 38 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 38;              // duct width (extrusion height)
port_r = 26.9;            // port flange half width
port_d = 53.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 21.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 38) {
    hull() {
      polygon([[28.383, -5.248], [-24.383, 5.248], [-22.822, 13.094], [29.944, 2.598]]);
      translate([4.146, 10.789]) circle(r = 17);
    }
    hull() {
      translate([4.146, 10.789]) circle(r = 17);
      translate([4.893, 14.542]) circle(r = 17);
    }
    hull() {
      translate([4.893, 14.542]) circle(r = 17);
      translate([13.13, 26.87]) circle(r = 17);
    }
    hull() {
      translate([13.13, 26.87]) circle(r = 17);
      translate([25.458, 35.107]) circle(r = 17);
    }
    hull() {
      translate([25.458, 35.107]) circle(r = 17);
      translate([40, 38]) circle(r = 17);
    }
    hull() {
      translate([40, 38]) circle(r = 17);
      translate([92.542, 40.893]) circle(r = 17);
    }
    hull() {
      translate([92.542, 40.893]) circle(r = 17);
      translate([104.87, 49.13]) circle(r = 17);
    }
    hull() {
      translate([104.87, 49.13]) circle(r = 17);
      translate([113.107, 61.458]) circle(r = 17);
    }
    hull() {
      translate([113.107, 61.458]) circle(r = 17);
      translate([113.854, 65.211]) circle(r = 17);
    }
    hull() {
      translate([113.854, 65.211]) circle(r = 17);
      polygon([[89.617, 81.248], [142.383, 70.752], [140.822, 62.906], [88.056, 73.402]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 33) {
    hull() {
      translate([1.025, -4.904]) circle(r = 14.5);
      translate([4.893, 14.542]) circle(r = 14.5);
    }
    hull() {
      translate([4.893, 14.542]) circle(r = 14.5);
      translate([13.13, 26.87]) circle(r = 14.5);
    }
    hull() {
      translate([13.13, 26.87]) circle(r = 14.5);
      translate([25.458, 35.107]) circle(r = 14.5);
    }
    hull() {
      translate([25.458, 35.107]) circle(r = 14.5);
      translate([40, 38]) circle(r = 14.5);
    }
    hull() {
      translate([40, 38]) circle(r = 14.5);
      translate([92.542, 40.893]) circle(r = 14.5);
    }
    hull() {
      translate([92.542, 40.893]) circle(r = 14.5);
      translate([104.87, 49.13]) circle(r = 14.5);
    }
    hull() {
      translate([104.87, 49.13]) circle(r = 14.5);
      translate([113.107, 61.458]) circle(r = 14.5);
    }
    hull() {
      translate([113.107, 61.458]) circle(r = 14.5);
      translate([116.975, 80.904]) circle(r = 14.5);
    }
  }
  translate([2, 0]) rotate([0, 0, -11.25]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([2, 0]) rotate([0, 0, -11.25]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([116, 76]) rotate([0, 0, 168.75]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([116, 76]) rotate([0, 0, 168.75]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
