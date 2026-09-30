$fn = 32;

// ------------------------------------------------------------------------
// Bolted plate: 110 x 60 x 12 mm plate, 3 fasteners
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module plate() {
  difference() {
    translate([-55, -30, 0]) cube([110, 60, 12]);
    translate([-33, 0, -1]) cylinder(h = 14, d = 6.8);
    translate([0, 0, -1]) cylinder(h = 14, d = 6.8);
    translate([33, 0, -1]) cylinder(h = 14, d = 6.8);
  }
}

// --- part 2 ---
module bolt1() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -26]) cylinder(h = 26, d = 6);
}

// --- part 3 ---
module bolt2() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -26]) cylinder(h = 26, d = 6);
}

// --- part 4 ---
module bolt3() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -26]) cylinder(h = 26, d = 6);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) plate();
  translate([-33, 0, 12.25]) rotate([0, 0, 0]) bolt1();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) bolt2();
  translate([33, 0, 12.25]) rotate([0, 0, 0]) bolt3();
}

assembly();
