$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 1 d30 standoffs, bolts d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-50, -35, 0]) cube([100, 70, 6]);
    translate([-31, 0, -1]) cylinder(h = 8, d = 8.8);
  }
}

// --- part 2 ---
module spacer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 20, d = 30);
      translate([0, 0, -1]) cylinder(h = 22, d = 8.8);
    }
}

// --- part 3 ---
module bolt() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -34.25]) cylinder(h = 34.25, d = 8);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-31, 0, 6.25]) rotate([0, 0, 0]) spacer();
  translate([-31, 0, 26.5]) rotate([0, 0, 0]) bolt();
}

assembly();
