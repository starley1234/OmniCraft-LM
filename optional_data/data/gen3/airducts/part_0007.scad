$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 4 mm wall, 26 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 26;              // duct width (extrusion height)
port_r = 19.9;            // port flange half width
port_d = 39.8;            // port flange width
port_t = 8;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 14.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 26) {
    hull() {
      polygon([[31.518, -3.882], [-7.518, 3.882], [-5.957, 11.729], [33.078, 3.964]]);
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
      polygon([[106.482, 79.882], [145.518, 72.118], [143.957, 64.271], [104.922, 72.036]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 18) {
    hull() {
      translate([11.025, -4.904]) circle(r = 6);
      translate([14.893, 14.542]) circle(r = 6);
    }
    hull() {
      translate([14.893, 14.542]) circle(r = 6);
      translate([23.13, 26.87]) circle(r = 6);
    }
    hull() {
      translate([23.13, 26.87]) circle(r = 6);
      translate([35.458, 35.107]) circle(r = 6);
    }
    hull() {
      translate([35.458, 35.107]) circle(r = 6);
      translate([50, 38]) circle(r = 6);
    }
    hull() {
      translate([50, 38]) circle(r = 6);
      translate([102.542, 40.893]) circle(r = 6);
    }
    hull() {
      translate([102.542, 40.893]) circle(r = 6);
      translate([114.87, 49.13]) circle(r = 6);
    }
    hull() {
      translate([114.87, 49.13]) circle(r = 6);
      translate([123.107, 61.458]) circle(r = 6);
    }
    hull() {
      translate([123.107, 61.458]) circle(r = 6);
      translate([126.975, 80.904]) circle(r = 6);
    }
  }
  translate([12, 0]) rotate([0, 0, -11.25]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([12, 0]) rotate([0, 0, -11.25]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([126, 76]) rotate([0, 0, 168.75]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
  translate([126, 76]) rotate([0, 0, 168.75]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 13, d = 5.4);
}
