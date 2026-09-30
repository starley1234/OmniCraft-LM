$fn = 32;

// ------------------------------------------------------------------------
// Bolted bracket: 100 x 50 mm bracket with 1 bolt joints
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module bracket() {
  difference() {
    translate([-50, -25, 0]) cube([100, 50, 60]);
    translate([-51, -26, 8]) cube([89, 52, 53]);
    translate([44, 0, 28]) rotate([0, 90, 0]) cylinder(h = 14, d = 8.8, center = true);
  }
}

// --- part 2 ---
module bolt() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -22.98]) cylinder(h = 22.98, d = 8);
}

// --- part 3 ---
module washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 16);
      translate([0, 0, -1]) cylinder(h = 4, d = 8.8);
    }
}

// --- part 4 ---
module nut() {
  difference() {
    linear_extrude(height = 6.4) polygon(points = [[7.506, 0], [3.753, 6.5], [-3.753, 6.5], [-7.506, 0], [-3.753, -6.5], [3.753, -6.5]]);
    translate([0, 0, -1]) cylinder(h = 8.4, d = 8.8);
  }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) bracket();
  translate([50.25, 0, 28]) rotate([0, 90, 0]) bolt();
  translate([35.75, 0, 28]) rotate([0, 90, 0]) washer();
  translate([29.1, 0, 28]) rotate([0, 90, 0]) nut();
}

assembly();
