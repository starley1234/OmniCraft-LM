$fn = 32;

// ------------------------------------------------------------------------
// Bolted plate: 150 x 80 x 10 mm plate, 3 fasteners
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module plate() {
  difference() {
    translate([-75, -40, 0]) cube([150, 80, 10]);
    translate([-45, 0, -1]) cylinder(h = 12, d = 10.8);
    translate([0, 0, -1]) cylinder(h = 12, d = 10.8);
    translate([45, 0, -1]) cylinder(h = 12, d = 10.8);
  }
}

// --- part 2 ---
module bolt1() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -24]) cylinder(h = 24, d = 10);
}

// --- part 3 ---
module bolt2() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -24]) cylinder(h = 24, d = 10);
}

// --- part 4 ---
module bolt3() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -24]) cylinder(h = 24, d = 10);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) plate();
  translate([-45, 0, 10.25]) rotate([0, 0, 0]) bolt1();
  translate([0, 0, 10.25]) rotate([0, 0, 0]) bolt2();
  translate([45, 0, 10.25]) rotate([0, 0, 0]) bolt3();
}

assembly();
