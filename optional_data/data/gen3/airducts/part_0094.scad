$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 3 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 3;                 // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 21.9;            // port flange half width
port_d = 43.8;            // port flange width
port_t = 7;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 16.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[33.479, -4.272], [-9.479, 4.272], [-8.114, 11.138], [34.845, 2.593]]);
      translate([13.951, 9.808]) circle(r = 12);
    }
    hull() {
      translate([13.951, 9.808]) circle(r = 12);
      translate([14.893, 14.542]) circle(r = 12);
    }
    hull() {
      translate([14.893, 14.542]) circle(r = 12);
      translate([23.13, 26.87]) circle(r = 12);
    }
    hull() {
      translate([23.13, 26.87]) circle(r = 12);
      translate([35.458, 35.107]) circle(r = 12);
    }
    hull() {
      translate([35.458, 35.107]) circle(r = 12);
      translate([50, 38]) circle(r = 12);
    }
    hull() {
      translate([50, 38]) circle(r = 12);
      translate([102.542, 40.893]) circle(r = 12);
    }
    hull() {
      translate([102.542, 40.893]) circle(r = 12);
      translate([114.87, 49.13]) circle(r = 12);
    }
    hull() {
      translate([114.87, 49.13]) circle(r = 12);
      translate([123.107, 61.458]) circle(r = 12);
    }
    hull() {
      translate([123.107, 61.458]) circle(r = 12);
      translate([124.049, 66.192]) circle(r = 12);
    }
    hull() {
      translate([124.049, 66.192]) circle(r = 12);
      polygon([[104.521, 80.272], [147.479, 71.728], [146.114, 64.862], [103.155, 73.407]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 3]) linear_extrude(height = 38) {
    hull() {
      translate([11.025, -4.904]) circle(r = 9);
      translate([14.893, 14.542]) circle(r = 9);
    }
    hull() {
      translate([14.893, 14.542]) circle(r = 9);
      translate([23.13, 26.87]) circle(r = 9);
    }
    hull() {
      translate([23.13, 26.87]) circle(r = 9);
      translate([35.458, 35.107]) circle(r = 9);
    }
    hull() {
      translate([35.458, 35.107]) circle(r = 9);
      translate([50, 38]) circle(r = 9);
    }
    hull() {
      translate([50, 38]) circle(r = 9);
      translate([102.542, 40.893]) circle(r = 9);
    }
    hull() {
      translate([102.542, 40.893]) circle(r = 9);
      translate([114.87, 49.13]) circle(r = 9);
    }
    hull() {
      translate([114.87, 49.13]) circle(r = 9);
      translate([123.107, 61.458]) circle(r = 9);
    }
    hull() {
      translate([123.107, 61.458]) circle(r = 9);
      translate([126.975, 80.904]) circle(r = 9);
    }
  }
  translate([12, 0]) rotate([0, 0, -11.25]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([12, 0]) rotate([0, 0, -11.25]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([126, 76]) rotate([0, 0, 168.75]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
  translate([126, 76]) rotate([0, 0, 168.75]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 12, d = 5.4);
}
