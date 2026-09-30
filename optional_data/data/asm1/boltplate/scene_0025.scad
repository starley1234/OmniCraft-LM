$fn = 32;

// ------------------------------------------------------------------------
// Bolted plate: 130 x 60 x 6 mm plate, 3 fasteners
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module plate() {
  difference() {
    translate([-65, -30, 0]) cube([130, 60, 6]);
    translate([-39, 0, -1]) cylinder(h = 8, d = 10.8);
    translate([0, 0, -1]) cylinder(h = 8, d = 10.8);
    translate([39, 0, -1]) cylinder(h = 8, d = 10.8);
  }
}

// --- part 2 ---
module bolt1() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -20]) cylinder(h = 20, d = 10);
}

// --- part 3 ---
module bolt2() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -20]) cylinder(h = 20, d = 10);
}

// --- part 4 ---
module bolt3() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -20]) cylinder(h = 20, d = 10);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) plate();
  translate([-39, 0, 6.25]) rotate([0, 0, 0]) bolt1();
  translate([0, 0, 6.25]) rotate([0, 0, 0]) bolt2();
  translate([39, 0, 6.25]) rotate([0, 0, 0]) bolt3();
}

assembly();
