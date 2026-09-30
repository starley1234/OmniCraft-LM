$fn = 32;

// ------------------------------------------------------------------------
// Bolted bracket: 80 x 70 mm bracket with 1 bolt joints
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module bracket() {
  difference() {
    translate([-40, -35, 0]) cube([80, 70, 75]);
    translate([-41, -36, 10]) cube([67, 72, 66]);
    translate([33, 0, 28]) rotate([0, 90, 0]) cylinder(h = 16, d = 8.8, center = true);
  }
}

// --- part 2 ---
module bolt() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -24.98]) cylinder(h = 24.98, d = 8);
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
  translate([40.25, 0, 28]) rotate([0, 90, 0]) bolt();
  translate([23.75, 0, 28]) rotate([0, 90, 0]) washer();
  translate([17.1, 0, 28]) rotate([0, 90, 0]) nut();
}

assembly();
