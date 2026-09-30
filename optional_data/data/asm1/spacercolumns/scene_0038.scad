$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 2 d26 standoffs, bolts d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-50, -40, 0]) cube([100, 80, 10]);
    translate([-33, 0, -1]) cylinder(h = 12, d = 8.8);
    translate([33, 0, -1]) cylinder(h = 12, d = 8.8);
  }
}

// --- part 2 ---
module spacer1() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 26);
      translate([0, 0, -1]) cylinder(h = 14, d = 8.8);
    }
}

// --- part 3 ---
module bolt1() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -30.25]) cylinder(h = 30.25, d = 8);
}

// --- part 4 ---
module spacer2() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 26);
      translate([0, 0, -1]) cylinder(h = 14, d = 8.8);
    }
}

// --- part 5 ---
module bolt2() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -30.25]) cylinder(h = 30.25, d = 8);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-33, 0, 10.25]) rotate([0, 0, 0]) spacer1();
  translate([-33, 0, 22.5]) rotate([0, 0, 0]) bolt1();
  translate([33, 0, 10.25]) rotate([0, 0, 0]) spacer2();
  translate([33, 0, 22.5]) rotate([0, 0, 0]) bolt2();
}

assembly();
