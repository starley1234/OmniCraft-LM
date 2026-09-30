$fn = 32;

// ------------------------------------------------------------------------
// Flange with gasket and cover: d170 flange stack, 6 bolt holes
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange() {
  difference() {
    cylinder(h = 14, d = 170);
    translate([0, 0, -1]) cylinder(h = 16, d = 80);
    translate([62.5, 0, -1]) cylinder(h = 16, d = 10.8);
    translate([31.25, 54.127, -1]) cylinder(h = 16, d = 10.8);
    translate([-31.25, 54.127, -1]) cylinder(h = 16, d = 10.8);
    translate([-62.5, 0, -1]) cylinder(h = 16, d = 10.8);
    translate([-31.25, -54.127, -1]) cylinder(h = 16, d = 10.8);
    translate([31.25, -54.127, -1]) cylinder(h = 16, d = 10.8);
  }
}

// --- part 2 ---
module gasket() {
  difference() {
    cylinder(h = 3, d = 170);
    translate([0, 0, -1]) cylinder(h = 5, d = 80);
    translate([62.5, 0, -1]) cylinder(h = 5, d = 10.8);
    translate([31.25, 54.127, -1]) cylinder(h = 5, d = 10.8);
    translate([-31.25, 54.127, -1]) cylinder(h = 5, d = 10.8);
    translate([-62.5, 0, -1]) cylinder(h = 5, d = 10.8);
    translate([-31.25, -54.127, -1]) cylinder(h = 5, d = 10.8);
    translate([31.25, -54.127, -1]) cylinder(h = 5, d = 10.8);
  }
}

// --- part 3 ---
module cover() {
  difference() {
    cylinder(h = 10, d = 170);
    translate([0, 0, -1]) cylinder(h = 12, d = 80);
    translate([62.5, 0, -1]) cylinder(h = 12, d = 10.8);
    translate([31.25, 54.127, -1]) cylinder(h = 12, d = 10.8);
    translate([-31.25, 54.127, -1]) cylinder(h = 12, d = 10.8);
    translate([-62.5, 0, -1]) cylinder(h = 12, d = 10.8);
    translate([-31.25, -54.127, -1]) cylinder(h = 12, d = 10.8);
    translate([31.25, -54.127, -1]) cylinder(h = 12, d = 10.8);
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
  translate([0, 0, 14.25]) rotate([0, 0, 0]) gasket();
  translate([0, 0, 17.5]) rotate([0, 0, 0]) cover();
  translate([62.5, 0, 27.75]) rotate([0, 0, 0]) bolt();
  translate([62.5, 0, -8.25]) rotate([0, 0, 0]) nut();
}

assembly();
