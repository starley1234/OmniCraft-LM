$fn = 32;

// ------------------------------------------------------------------------
// Bolted plate: 90 x 70 x 10 mm plate, 3 fasteners
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module plate() {
  difference() {
    translate([-45, -35, 0]) cube([90, 70, 10]);
    translate([-27, 0, -1]) cylinder(h = 12, d = 6.8);
    translate([0, 0, -1]) cylinder(h = 12, d = 6.8);
    translate([27, 0, -1]) cylinder(h = 12, d = 6.8);
  }
}

// --- part 2 ---
module bolt1() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -24]) cylinder(h = 24, d = 6);
}

// --- part 3 ---
module bolt2() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -24]) cylinder(h = 24, d = 6);
}

// --- part 4 ---
module bolt3() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -24]) cylinder(h = 24, d = 6);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) plate();
  translate([-27, 0, 10.25]) rotate([0, 0, 0]) bolt1();
  translate([0, 0, 10.25]) rotate([0, 0, 0]) bolt2();
  translate([27, 0, 10.25]) rotate([0, 0, 0]) bolt3();
}

assembly();
