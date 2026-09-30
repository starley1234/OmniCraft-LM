$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 1 d26 standoffs, bolts d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-60, -40, 0]) cube([120, 80, 8]);
    translate([-38.4, 0, -1]) cylinder(h = 10, d = 8.8);
  }
}

// --- part 2 ---
module spacer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 26);
      translate([0, 0, -1]) cylinder(h = 14, d = 8.8);
    }
}

// --- part 3 ---
module bolt() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -28.25]) cylinder(h = 28.25, d = 8);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-38.4, 0, 8.25]) rotate([0, 0, 0]) spacer();
  translate([-38.4, 0, 20.5]) rotate([0, 0, 0]) bolt();
}

assembly();
