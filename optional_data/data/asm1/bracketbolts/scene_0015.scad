$fn = 32;

// ------------------------------------------------------------------------
// Bolted bracket: 80 x 70 mm bracket with 2 bolt joints
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module bracket() {
  difference() {
    translate([-40, -35, 0]) cube([80, 70, 90]);
    translate([-41, -36, 10]) cube([67, 72, 81]);
    translate([33, 0, 32]) rotate([0, 90, 0]) cylinder(h = 16, d = 10.8, center = true);
    translate([33, 0, 52]) rotate([0, 90, 0]) cylinder(h = 16, d = 10.8, center = true);
  }
}

// --- part 2 ---
module bolt1() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -26.1]) cylinder(h = 26.1, d = 10);
}

// --- part 3 ---
module washer1() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 18);
      translate([0, 0, -1]) cylinder(h = 4, d = 10.8);
    }
}

// --- part 4 ---
module bolt2() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -26.1]) cylinder(h = 26.1, d = 10);
}

// --- part 5 ---
module washer2() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 18);
      translate([0, 0, -1]) cylinder(h = 4, d = 10.8);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) bracket();
  translate([40.25, 0, 32]) rotate([0, 90, 0]) bolt1();
  translate([23.75, 0, 32]) rotate([0, 90, 0]) washer1();
  translate([40.25, 0, 52]) rotate([0, 90, 0]) bolt2();
  translate([23.75, 0, 52]) rotate([0, 90, 0]) washer2();
}

assembly();
