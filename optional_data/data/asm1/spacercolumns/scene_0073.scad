$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 2 d22 standoffs, bolts d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-50, -30, 0]) cube([100, 60, 6]);
    translate([-32, 0, -1]) cylinder(h = 8, d = 8.8);
    translate([32, 0, -1]) cylinder(h = 8, d = 8.8);
  }
}

// --- part 2 ---
module spacer1() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 20, d = 22);
      translate([0, 0, -1]) cylinder(h = 22, d = 8.8);
    }
}

// --- part 3 ---
module bolt1() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -34.25]) cylinder(h = 34.25, d = 8);
}

// --- part 4 ---
module spacer2() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 20, d = 22);
      translate([0, 0, -1]) cylinder(h = 22, d = 8.8);
    }
}

// --- part 5 ---
module bolt2() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -34.25]) cylinder(h = 34.25, d = 8);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-32, 0, 6.25]) rotate([0, 0, 0]) spacer1();
  translate([-32, 0, 26.5]) rotate([0, 0, 0]) bolt1();
  translate([32, 0, 6.25]) rotate([0, 0, 0]) spacer2();
  translate([32, 0, 26.5]) rotate([0, 0, 0]) bolt2();
}

assembly();
