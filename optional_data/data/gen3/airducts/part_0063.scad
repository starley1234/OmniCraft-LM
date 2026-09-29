$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 2.5 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 2.5;               // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 18.9;            // port flange half width
port_d = 37.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 4.4;             // port bolt holes
bolt_offset = 14.2;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[30.537, -3.687], [-6.537, 3.687], [-4.976, 11.533], [32.098, 4.159]]);
      translate([14.146, 10.789]) circle(r = 10);
    }
    hull() {
      translate([14.146, 10.789]) circle(r = 10);
      translate([14.893, 14.542]) circle(r = 10);
    }
    hull() {
      translate([14.893, 14.542]) circle(r = 10);
      translate([23.13, 26.87]) circle(r = 10);
    }
    hull() {
      translate([23.13, 26.87]) circle(r = 10);
      translate([35.458, 35.107]) circle(r = 10);
    }
    hull() {
      translate([35.458, 35.107]) circle(r = 10);
      translate([50, 38]) circle(r = 10);
    }
    hull() {
      translate([50, 38]) circle(r = 10);
      translate([102.542, 40.893]) circle(r = 10);
    }
    hull() {
      translate([102.542, 40.893]) circle(r = 10);
      translate([114.87, 49.13]) circle(r = 10);
    }
    hull() {
      translate([114.87, 49.13]) circle(r = 10);
      translate([123.107, 61.458]) circle(r = 10);
    }
    hull() {
      translate([123.107, 61.458]) circle(r = 10);
      translate([123.854, 65.211]) circle(r = 10);
    }
    hull() {
      translate([123.854, 65.211]) circle(r = 10);
      polygon([[107.463, 79.687], [144.537, 72.313], [142.976, 64.467], [105.902, 71.841]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 2.5]) linear_extrude(height = 27) {
    hull() {
      translate([11.025, -4.904]) circle(r = 7.5);
      translate([14.893, 14.542]) circle(r = 7.5);
    }
    hull() {
      translate([14.893, 14.542]) circle(r = 7.5);
      translate([23.13, 26.87]) circle(r = 7.5);
    }
    hull() {
      translate([23.13, 26.87]) circle(r = 7.5);
      translate([35.458, 35.107]) circle(r = 7.5);
    }
    hull() {
      translate([35.458, 35.107]) circle(r = 7.5);
      translate([50, 38]) circle(r = 7.5);
    }
    hull() {
      translate([50, 38]) circle(r = 7.5);
      translate([102.542, 40.893]) circle(r = 7.5);
    }
    hull() {
      translate([102.542, 40.893]) circle(r = 7.5);
      translate([114.87, 49.13]) circle(r = 7.5);
    }
    hull() {
      translate([114.87, 49.13]) circle(r = 7.5);
      translate([123.107, 61.458]) circle(r = 7.5);
    }
    hull() {
      translate([123.107, 61.458]) circle(r = 7.5);
      translate([126.975, 80.904]) circle(r = 7.5);
    }
  }
  translate([12, 0]) rotate([0, 0, -11.25]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([12, 0]) rotate([0, 0, -11.25]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([126, 76]) rotate([0, 0, 168.75]) translate([-14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
  translate([126, 76]) rotate([0, 0, 168.75]) translate([14.2, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 4.4);
}
