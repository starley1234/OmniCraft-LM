$fn = 32;

// ------------------------------------------------------------------------
// Standoff columns: 2 d32 standoffs, bolts d10
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-70, -35, 0]) cube([140, 70, 8]);
    translate([-44.8, 0, -1]) cylinder(h = 10, d = 10.8);
    translate([44.8, 0, -1]) cylinder(h = 10, d = 10.8);
  }
}

// --- part 2 ---
module spacer1() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 32);
      translate([0, 0, -1]) cylinder(h = 14, d = 10.8);
    }
}

// --- part 3 ---
module bolt1() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -28.25]) cylinder(h = 28.25, d = 10);
}

// --- part 4 ---
module spacer2() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 32);
      translate([0, 0, -1]) cylinder(h = 14, d = 10.8);
    }
}

// --- part 5 ---
module bolt2() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -28.25]) cylinder(h = 28.25, d = 10);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_plate();
  translate([-44.8, 0, 8.25]) rotate([0, 0, 0]) spacer1();
  translate([-44.8, 0, 20.5]) rotate([0, 0, 0]) bolt1();
  translate([44.8, 0, 8.25]) rotate([0, 0, 0]) spacer2();
  translate([44.8, 0, 20.5]) rotate([0, 0, 0]) bolt2();
}

assembly();
