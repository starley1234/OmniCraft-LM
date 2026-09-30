$fn = 32;

// ------------------------------------------------------------------------
// Bolted plate: 170 x 70 x 12 mm plate, 2 fasteners
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module plate() {
  difference() {
    translate([-85, -35, 0]) cube([170, 70, 12]);
    translate([-47.6, 0, -1]) cylinder(h = 14, d = 6.8);
    translate([47.6, 0, -1]) cylinder(h = 14, d = 6.8);
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
module nut1() {
  difference() {
    linear_extrude(height = 4.8) polygon(points = [[5.774, 0], [2.887, 5], [-2.887, 5], [-5.774, 0], [-2.887, -5], [2.887, -5]]);
    translate([0, 0, -1]) cylinder(h = 6.8, d = 6.8);
  }
}

// --- part 5 ---
module nut2() {
  difference() {
    linear_extrude(height = 4.8) polygon(points = [[5.774, 0], [2.887, 5], [-2.887, 5], [-5.774, 0], [-2.887, -5], [2.887, -5]]);
    translate([0, 0, -1]) cylinder(h = 6.8, d = 6.8);
  }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) plate();
  translate([-47.6, 0, 12.25]) rotate([0, 0, 0]) bolt1();
  translate([47.6, 0, 12.25]) rotate([0, 0, 0]) bolt2();
  translate([-47.6, 0, -5.05]) rotate([0, 0, 0]) nut1();
  translate([47.6, 0, -5.05]) rotate([0, 0, 0]) nut2();
}

assembly();
