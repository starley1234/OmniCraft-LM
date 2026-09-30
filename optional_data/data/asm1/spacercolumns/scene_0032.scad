$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 1 d20 standoffs, bolts d6
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-50, -40, 0]) cube([100, 80, 8]);
    translate([-32, 0, -1]) cylinder(h = 10, d = 6.8);
  }
}

// --- part 2 ---
module spacer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 16, d = 20);
      translate([0, 0, -1]) cylinder(h = 18, d = 6.8);
    }
}

// --- part 3 ---
module bolt() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -32.25]) cylinder(h = 32.25, d = 6);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-32, 0, 8.25]) rotate([0, 0, 0]) spacer();
  translate([-32, 0, 24.5]) rotate([0, 0, 0]) bolt();
}

assembly();
