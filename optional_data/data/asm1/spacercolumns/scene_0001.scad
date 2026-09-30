$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 2 d28 standoffs, bolts d6
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-60, -40, 0]) cube([120, 80, 8]);
    translate([-38.4, 0, -1]) cylinder(h = 10, d = 6.8);
    translate([38.4, 0, -1]) cylinder(h = 10, d = 6.8);
  }
}

// --- part 2 ---
module spacer1() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 20, d = 28);
      translate([0, 0, -1]) cylinder(h = 22, d = 6.8);
    }
}

// --- part 3 ---
module bolt1() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -36.25]) cylinder(h = 36.25, d = 6);
}

// --- part 4 ---
module spacer2() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 20, d = 28);
      translate([0, 0, -1]) cylinder(h = 22, d = 6.8);
    }
}

// --- part 5 ---
module bolt2() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -36.25]) cylinder(h = 36.25, d = 6);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-38.4, 0, 8.25]) rotate([0, 0, 0]) spacer1();
  translate([-38.4, 0, 28.5]) rotate([0, 0, 0]) bolt1();
  translate([38.4, 0, 8.25]) rotate([0, 0, 0]) spacer2();
  translate([38.4, 0, 28.5]) rotate([0, 0, 0]) bolt2();
}

assembly();
