$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 1 d24 standoffs, bolts d6
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-70, -30, 0]) cube([140, 60, 6]);
    translate([-44.8, 0, -1]) cylinder(h = 8, d = 6.8);
  }
}

// --- part 2 ---
module spacer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 24);
      translate([0, 0, -1]) cylinder(h = 14, d = 6.8);
    }
}

// --- part 3 ---
module bolt() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -26.25]) cylinder(h = 26.25, d = 6);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-44.8, 0, 6.25]) rotate([0, 0, 0]) spacer();
  translate([-44.8, 0, 18.5]) rotate([0, 0, 0]) bolt();
}

assembly();
