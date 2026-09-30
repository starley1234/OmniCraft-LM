$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 1 d32 standoffs, bolts d10
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-60, -35, 0]) cube([120, 70, 8]);
    translate([-40, 0, -1]) cylinder(h = 10, d = 10.8);
  }
}

// --- part 2 ---
module spacer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 16, d = 32);
      translate([0, 0, -1]) cylinder(h = 18, d = 10.8);
    }
}

// --- part 3 ---
module bolt() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -32.25]) cylinder(h = 32.25, d = 10);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-40, 0, 8.25]) rotate([0, 0, 0]) spacer();
  translate([-40, 0, 24.5]) rotate([0, 0, 0]) bolt();
}

assembly();
