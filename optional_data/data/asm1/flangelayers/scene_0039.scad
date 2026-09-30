$fn = 32;

// ------------------------------------------------------------------------
// Flange with gasket and cover: d150 flange stack, 6 bolt holes
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange() {
  difference() {
    cylinder(h = 16, d = 150);
    translate([0, 0, -1]) cylinder(h = 18, d = 80);
    translate([57.5, 0, -1]) cylinder(h = 18, d = 10.8);
    translate([28.75, 49.796, -1]) cylinder(h = 18, d = 10.8);
    translate([-28.75, 49.796, -1]) cylinder(h = 18, d = 10.8);
    translate([-57.5, 0, -1]) cylinder(h = 18, d = 10.8);
    translate([-28.75, -49.796, -1]) cylinder(h = 18, d = 10.8);
    translate([28.75, -49.796, -1]) cylinder(h = 18, d = 10.8);
  }
}

// --- part 2 ---
module gasket() {
  difference() {
    cylinder(h = 3, d = 150);
    translate([0, 0, -1]) cylinder(h = 5, d = 80);
    translate([57.5, 0, -1]) cylinder(h = 5, d = 10.8);
    translate([28.75, 49.796, -1]) cylinder(h = 5, d = 10.8);
    translate([-28.75, 49.796, -1]) cylinder(h = 5, d = 10.8);
    translate([-57.5, 0, -1]) cylinder(h = 5, d = 10.8);
    translate([-28.75, -49.796, -1]) cylinder(h = 5, d = 10.8);
    translate([28.75, -49.796, -1]) cylinder(h = 5, d = 10.8);
  }
}

// --- part 3 ---
module cover() {
  difference() {
    cylinder(h = 8, d = 150);
    translate([0, 0, -1]) cylinder(h = 10, d = 80);
    translate([57.5, 0, -1]) cylinder(h = 10, d = 10.8);
    translate([28.75, 49.796, -1]) cylinder(h = 10, d = 10.8);
    translate([-28.75, 49.796, -1]) cylinder(h = 10, d = 10.8);
    translate([-57.5, 0, -1]) cylinder(h = 10, d = 10.8);
    translate([-28.75, -49.796, -1]) cylinder(h = 10, d = 10.8);
    translate([28.75, -49.796, -1]) cylinder(h = 10, d = 10.8);
  }
}

// --- part 4 ---
module bolt() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -51.75]) cylinder(h = 51.75, d = 10);
}

// --- part 5 ---
module nut() {
  difference() {
    linear_extrude(height = 8) polygon(points = [[9.815, 0], [4.907, 8.5], [-4.907, 8.5], [-9.815, 0], [-4.907, -8.5], [4.907, -8.5]]);
    translate([0, 0, -1]) cylinder(h = 10, d = 10.8);
  }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) flange();
  translate([0, 0, 16.25]) rotate([0, 0, 0]) gasket();
  translate([0, 0, 19.5]) rotate([0, 0, 0]) cover();
  translate([57.5, 0, 27.75]) rotate([0, 0, 0]) bolt();
  translate([57.5, 0, -8.25]) rotate([0, 0, 0]) nut();
}

assembly();
