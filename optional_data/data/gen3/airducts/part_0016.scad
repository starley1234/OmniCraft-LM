$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 24 mm duct, 4 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 12;              // duct core radius
duct_d = 24;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 21.9;            // port flange half width
port_d = 43.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 16.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[13.479, -4.272], [-29.479, 4.272], [-28.309, 10.157], [14.65, 1.612]]);
      translate([-6.244, 8.827]) circle(r = 12);
    }
    hull() {
      translate([-6.244, 8.827]) circle(r = 12);
      translate([-5.107, 14.542]) circle(r = 12);
    }
    hull() {
      translate([-5.107, 14.542]) circle(r = 12);
      translate([3.13, 26.87]) circle(r = 12);
    }
    hull() {
      translate([3.13, 26.87]) circle(r = 12);
      translate([15.458, 35.107]) circle(r = 12);
    }
    hull() {
      translate([15.458, 35.107]) circle(r = 12);
      translate([30, 38]) circle(r = 12);
    }
    hull() {
      translate([30, 38]) circle(r = 12);
      translate([82.542, 40.893]) circle(r = 12);
    }
    hull() {
      translate([82.542, 40.893]) circle(r = 12);
      translate([94.87, 49.13]) circle(r = 12);
    }
    hull() {
      translate([94.87, 49.13]) circle(r = 12);
      translate([103.107, 61.458]) circle(r = 12);
    }
    hull() {
      translate([103.107, 61.458]) circle(r = 12);
      translate([104.244, 67.173]) circle(r = 12);
    }
    hull() {
      translate([104.244, 67.173]) circle(r = 12);
      polygon([[84.521, 80.272], [127.479, 71.728], [126.309, 65.843], [83.35, 74.388]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 36) {
    hull() {
      translate([-8.975, -4.904]) circle(r = 8);
      translate([-5.107, 14.542]) circle(r = 8);
    }
    hull() {
      translate([-5.107, 14.542]) circle(r = 8);
      translate([3.13, 26.87]) circle(r = 8);
    }
    hull() {
      translate([3.13, 26.87]) circle(r = 8);
      translate([15.458, 35.107]) circle(r = 8);
    }
    hull() {
      translate([15.458, 35.107]) circle(r = 8);
      translate([30, 38]) circle(r = 8);
    }
    hull() {
      translate([30, 38]) circle(r = 8);
      translate([82.542, 40.893]) circle(r = 8);
    }
    hull() {
      translate([82.542, 40.893]) circle(r = 8);
      translate([94.87, 49.13]) circle(r = 8);
    }
    hull() {
      translate([94.87, 49.13]) circle(r = 8);
      translate([103.107, 61.458]) circle(r = 8);
    }
    hull() {
      translate([103.107, 61.458]) circle(r = 8);
      translate([106.975, 80.904]) circle(r = 8);
    }
  }
  translate([-8, 0]) rotate([0, 0, -11.25]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([-8, 0]) rotate([0, 0, -11.25]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([106, 76]) rotate([0, 0, 168.75]) translate([-16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([106, 76]) rotate([0, 0, 168.75]) translate([16.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
