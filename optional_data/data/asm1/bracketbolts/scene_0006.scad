$fn = 32;

// ------------------------------------------------------------------------
// Bolted bracket: 80 x 60 mm bracket with 1 bolt joints
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module bracket() {
  difference() {
    translate([-40, -30, 0]) cube([80, 60, 90]);
    translate([-41, -31, 10]) cube([67, 62, 81]);
    translate([33, 0, 28]) rotate([0, 90, 0]) cylinder(h = 16, d = 6.8, center = true);
  }
}

// --- part 2 ---
module bolt() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -23.86]) cylinder(h = 23.86, d = 6);
}

// --- part 3 ---
module washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 14);
      translate([0, 0, -1]) cylinder(h = 4, d = 6.8);
    }
}

// --- part 4 ---
module nut() {
  difference() {
    linear_extrude(height = 4.8) polygon(points = [[5.774, 0], [2.887, 5], [-2.887, 5], [-5.774, 0], [-2.887, -5], [2.887, -5]]);
    translate([0, 0, -1]) cylinder(h = 6.8, d = 6.8);
  }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) bracket();
  translate([40.25, 0, 28]) rotate([0, 90, 0]) bolt();
  translate([23.75, 0, 28]) rotate([0, 90, 0]) washer();
  translate([18.7, 0, 28]) rotate([0, 90, 0]) nut();
}

assembly();
