$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 1 d26 standoffs, bolts d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-70, -40, 0]) cube([140, 80, 10]);
    translate([-44.8, 0, -1]) cylinder(h = 12, d = 8.8);
  }
}

// --- part 2 ---
module spacer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 20, d = 26);
      translate([0, 0, -1]) cylinder(h = 22, d = 8.8);
    }
}

// --- part 3 ---
module bolt() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -38.25]) cylinder(h = 38.25, d = 8);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-44.8, 0, 10.25]) rotate([0, 0, 0]) spacer();
  translate([-44.8, 0, 30.5]) rotate([0, 0, 0]) bolt();
}

assembly();
