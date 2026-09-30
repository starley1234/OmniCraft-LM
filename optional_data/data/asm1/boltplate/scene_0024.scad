$fn = 32;

// ------------------------------------------------------------------------
// Bolted plate: 130 x 80 x 6 mm plate, 2 fasteners
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module plate() {
  difference() {
    translate([-65, -40, 0]) cube([130, 80, 6]);
    translate([-36.4, 0, -1]) cylinder(h = 8, d = 6.8);
    translate([36.4, 0, -1]) cylinder(h = 8, d = 6.8);
  }
}

// --- part 2 ---
module bolt1() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -20]) cylinder(h = 20, d = 6);
}

// --- part 3 ---
module bolt2() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -20]) cylinder(h = 20, d = 6);
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
  translate([-36.4, 0, 6.25]) rotate([0, 0, 0]) bolt1();
  translate([36.4, 0, 6.25]) rotate([0, 0, 0]) bolt2();
  translate([-36.4, 0, -5.05]) rotate([0, 0, 0]) nut1();
  translate([36.4, 0, -5.05]) rotate([0, 0, 0]) nut2();
}

assembly();
