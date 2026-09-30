$fn = 32;

// ------------------------------------------------------------------------
// Bolted bracket: 120 x 60 mm bracket with 2 bolt joints
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module bracket() {
  difference() {
    translate([-60, -30, 0]) cube([120, 60, 75]);
    translate([-61, -31, 10]) cube([107, 62, 66]);
    translate([53, 0, 36]) rotate([0, 90, 0]) cylinder(h = 16, d = 10.8, center = true);
    translate([53, 0, 56]) rotate([0, 90, 0]) cylinder(h = 16, d = 10.8, center = true);
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
  translate([60.25, 0, 36]) rotate([0, 90, 0]) bolt1();
  translate([43.75, 0, 36]) rotate([0, 90, 0]) washer1();
  translate([60.25, 0, 56]) rotate([0, 90, 0]) bolt2();
  translate([43.75, 0, 56]) rotate([0, 90, 0]) washer2();
}

assembly();
