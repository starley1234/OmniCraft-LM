$fn = 32;

// ------------------------------------------------------------------------
// Flange with gasket and cover: d130 flange stack, 6 bolt holes
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange() {
  difference() {
    cylinder(h = 14, d = 130);
    translate([0, 0, -1]) cylinder(h = 16, d = 80);
    translate([52.5, 0, -1]) cylinder(h = 16, d = 12.8);
    translate([26.25, 45.466, -1]) cylinder(h = 16, d = 12.8);
    translate([-26.25, 45.466, -1]) cylinder(h = 16, d = 12.8);
    translate([-52.5, 0, -1]) cylinder(h = 16, d = 12.8);
    translate([-26.25, -45.466, -1]) cylinder(h = 16, d = 12.8);
    translate([26.25, -45.466, -1]) cylinder(h = 16, d = 12.8);
  }
}

// --- part 2 ---
module gasket() {
  difference() {
    cylinder(h = 3, d = 130);
    translate([0, 0, -1]) cylinder(h = 5, d = 80);
    translate([52.5, 0, -1]) cylinder(h = 5, d = 12.8);
    translate([26.25, 45.466, -1]) cylinder(h = 5, d = 12.8);
    translate([-26.25, 45.466, -1]) cylinder(h = 5, d = 12.8);
    translate([-52.5, 0, -1]) cylinder(h = 5, d = 12.8);
    translate([-26.25, -45.466, -1]) cylinder(h = 5, d = 12.8);
    translate([26.25, -45.466, -1]) cylinder(h = 5, d = 12.8);
  }
}

// --- part 3 ---
module cover() {
  difference() {
    cylinder(h = 10, d = 130);
    translate([0, 0, -1]) cylinder(h = 12, d = 80);
    translate([52.5, 0, -1]) cylinder(h = 12, d = 12.8);
    translate([26.25, 45.466, -1]) cylinder(h = 12, d = 12.8);
    translate([-26.25, 45.466, -1]) cylinder(h = 12, d = 12.8);
    translate([-52.5, 0, -1]) cylinder(h = 12, d = 12.8);
    translate([-26.25, -45.466, -1]) cylinder(h = 12, d = 12.8);
    translate([26.25, -45.466, -1]) cylinder(h = 12, d = 12.8);
  }
}

// --- part 4 ---
module bolt() {
  cylinder(h = 8.4, d = 18);
  translate([0, 0, -51.75]) cylinder(h = 51.75, d = 12);
}

// --- part 5 ---
module nut() {
  difference() {
    linear_extrude(height = 9.6) polygon(points = [[10.97, 0], [5.485, 9.5], [-5.485, 9.5], [-10.97, 0], [-5.485, -9.5], [5.485, -9.5]]);
    translate([0, 0, -1]) cylinder(h = 11.6, d = 12.8);
  }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) flange();
  translate([0, 0, 14.25]) rotate([0, 0, 0]) gasket();
  translate([0, 0, 17.5]) rotate([0, 0, 0]) cover();
  translate([52.5, 0, 27.75]) rotate([0, 0, 0]) bolt();
  translate([52.5, 0, -9.85]) rotate([0, 0, 0]) nut();
}

assembly();
