$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 1 d20 standoffs, bolts d6
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-70, -30, 0]) cube([140, 60, 10]);
    translate([-44.8, 0, -1]) cylinder(h = 12, d = 6.8);
  }
}

// --- part 2 ---
module spacer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 24, d = 20);
      translate([0, 0, -1]) cylinder(h = 26, d = 6.8);
    }
}

// --- part 3 ---
module bolt() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -42.25]) cylinder(h = 42.25, d = 6);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-44.8, 0, 10.25]) rotate([0, 0, 0]) spacer();
  translate([-44.8, 0, 34.5]) rotate([0, 0, 0]) bolt();
}

assembly();
