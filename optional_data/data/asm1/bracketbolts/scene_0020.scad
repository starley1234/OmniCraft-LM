$fn = 32;

// ------------------------------------------------------------------------
// Bolted bracket: 120 x 50 mm bracket with 2 bolt joints
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module bracket() {
  difference() {
    translate([-60, -25, 0]) cube([120, 50, 60]);
    translate([-61, -26, 8]) cube([109, 52, 53]);
    translate([54, 0, 28]) rotate([0, 90, 0]) cylinder(h = 14, d = 8.8, center = true);
    translate([54, 0, 46]) rotate([0, 90, 0]) cylinder(h = 14, d = 8.8, center = true);
  }
}

// --- part 2 ---
module bolt1() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -22.98]) cylinder(h = 22.98, d = 8);
}

// --- part 3 ---
module washer1() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 16);
      translate([0, 0, -1]) cylinder(h = 4, d = 8.8);
    }
}

// --- part 4 ---
module bolt2() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -22.98]) cylinder(h = 22.98, d = 8);
}

// --- part 5 ---
module washer2() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 16);
      translate([0, 0, -1]) cylinder(h = 4, d = 8.8);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) bracket();
  translate([60.25, 0, 28]) rotate([0, 90, 0]) bolt1();
  translate([45.75, 0, 28]) rotate([0, 90, 0]) washer1();
  translate([60.25, 0, 46]) rotate([0, 90, 0]) bolt2();
  translate([45.75, 0, 46]) rotate([0, 90, 0]) washer2();
}

assembly();
