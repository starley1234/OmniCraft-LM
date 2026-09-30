$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 2 d28 standoffs, bolts d6
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-70, -35, 0]) cube([140, 70, 6]);
    translate([-44.8, 0, -1]) cylinder(h = 8, d = 6.8);
    translate([44.8, 0, -1]) cylinder(h = 8, d = 6.8);
  }
}

// --- part 2 ---
module spacer1() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 24, d = 28);
      translate([0, 0, -1]) cylinder(h = 26, d = 6.8);
    }
}

// --- part 3 ---
module bolt1() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -38.25]) cylinder(h = 38.25, d = 6);
}

// --- part 4 ---
module spacer2() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 24, d = 28);
      translate([0, 0, -1]) cylinder(h = 26, d = 6.8);
    }
}

// --- part 5 ---
module bolt2() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -38.25]) cylinder(h = 38.25, d = 6);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-44.8, 0, 6.25]) rotate([0, 0, 0]) spacer1();
  translate([-44.8, 0, 30.5]) rotate([0, 0, 0]) bolt1();
  translate([44.8, 0, 6.25]) rotate([0, 0, 0]) spacer2();
  translate([44.8, 0, 30.5]) rotate([0, 0, 0]) bolt2();
}

assembly();
