$fn = 32;

// ------------------------------------------------------------------------
// Bolted plate: 130 x 80 x 10 mm plate, 2 fasteners
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module plate() {
  difference() {
    translate([-65, -40, 0]) cube([130, 80, 10]);
    translate([-36.4, 0, -1]) cylinder(h = 12, d = 8.8);
    translate([36.4, 0, -1]) cylinder(h = 12, d = 8.8);
  }
}

// --- part 2 ---
module bolt1() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -24]) cylinder(h = 24, d = 8);
}

// --- part 3 ---
module bolt2() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -24]) cylinder(h = 24, d = 8);
}

// --- part 4 ---
module nut1() {
  difference() {
    linear_extrude(height = 6.4) polygon(points = [[7.506, 0], [3.753, 6.5], [-3.753, 6.5], [-7.506, 0], [-3.753, -6.5], [3.753, -6.5]]);
    translate([0, 0, -1]) cylinder(h = 8.4, d = 8.8);
  }
}

// --- part 5 ---
module nut2() {
  difference() {
    linear_extrude(height = 6.4) polygon(points = [[7.506, 0], [3.753, 6.5], [-3.753, 6.5], [-7.506, 0], [-3.753, -6.5], [3.753, -6.5]]);
    translate([0, 0, -1]) cylinder(h = 8.4, d = 8.8);
  }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) plate();
  translate([-36.4, 0, 10.25]) rotate([0, 0, 0]) bolt1();
  translate([36.4, 0, 10.25]) rotate([0, 0, 0]) bolt2();
  translate([-36.4, 0, -6.65]) rotate([0, 0, 0]) nut1();
  translate([36.4, 0, -6.65]) rotate([0, 0, 0]) nut2();
}

assembly();
