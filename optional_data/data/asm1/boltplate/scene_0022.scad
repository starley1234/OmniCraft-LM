$fn = 32;

// ------------------------------------------------------------------------
// Bolted plate: 130 x 70 x 12 mm plate, 3 fasteners
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module plate() {
  difference() {
    translate([-65, -35, 0]) cube([130, 70, 12]);
    translate([-39, 0, -1]) cylinder(h = 14, d = 8.8);
    translate([0, 0, -1]) cylinder(h = 14, d = 8.8);
    translate([39, 0, -1]) cylinder(h = 14, d = 8.8);
  }
}

// --- part 2 ---
module bolt1() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -26]) cylinder(h = 26, d = 8);
}

// --- part 3 ---
module bolt2() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -26]) cylinder(h = 26, d = 8);
}

// --- part 4 ---
module bolt3() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -26]) cylinder(h = 26, d = 8);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) plate();
  translate([-39, 0, 12.25]) rotate([0, 0, 0]) bolt1();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) bolt2();
  translate([39, 0, 12.25]) rotate([0, 0, 0]) bolt3();
}

assembly();
