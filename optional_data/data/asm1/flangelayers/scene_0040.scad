$fn = 32;

// ------------------------------------------------------------------------
// Flange with gasket and cover: d130 flange stack, 6 bolt holes
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange() {
  difference() {
    cylinder(h = 12, d = 130);
    translate([0, 0, -1]) cylinder(h = 14, d = 80);
    translate([52.5, 0, -1]) cylinder(h = 14, d = 8.8);
    translate([26.25, 45.466, -1]) cylinder(h = 14, d = 8.8);
    translate([-26.25, 45.466, -1]) cylinder(h = 14, d = 8.8);
    translate([-52.5, 0, -1]) cylinder(h = 14, d = 8.8);
    translate([-26.25, -45.466, -1]) cylinder(h = 14, d = 8.8);
    translate([26.25, -45.466, -1]) cylinder(h = 14, d = 8.8);
  }
}

// --- part 2 ---
module gasket() {
  difference() {
    cylinder(h = 3, d = 130);
    translate([0, 0, -1]) cylinder(h = 5, d = 80);
    translate([52.5, 0, -1]) cylinder(h = 5, d = 8.8);
    translate([26.25, 45.466, -1]) cylinder(h = 5, d = 8.8);
    translate([-26.25, 45.466, -1]) cylinder(h = 5, d = 8.8);
    translate([-52.5, 0, -1]) cylinder(h = 5, d = 8.8);
    translate([-26.25, -45.466, -1]) cylinder(h = 5, d = 8.8);
    translate([26.25, -45.466, -1]) cylinder(h = 5, d = 8.8);
  }
}

// --- part 3 ---
module cover() {
  difference() {
    cylinder(h = 8, d = 130);
    translate([0, 0, -1]) cylinder(h = 10, d = 80);
    translate([52.5, 0, -1]) cylinder(h = 10, d = 8.8);
    translate([26.25, 45.466, -1]) cylinder(h = 10, d = 8.8);
    translate([-26.25, 45.466, -1]) cylinder(h = 10, d = 8.8);
    translate([-52.5, 0, -1]) cylinder(h = 10, d = 8.8);
    translate([-26.25, -45.466, -1]) cylinder(h = 10, d = 8.8);
    translate([26.25, -45.466, -1]) cylinder(h = 10, d = 8.8);
  }
}

// --- part 4 ---
module bolt() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -47.75]) cylinder(h = 47.75, d = 8);
}

// --- part 5 ---
module nut() {
  difference() {
    linear_extrude(height = 6.4) polygon(points = [[7.506, 0], [3.753, 6.5], [-3.753, 6.5], [-7.506, 0], [-3.753, -6.5], [3.753, -6.5]]);
    translate([0, 0, -1]) cylinder(h = 8.4, d = 8.8);
  }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) flange();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) gasket();
  translate([0, 0, 15.5]) rotate([0, 0, 0]) cover();
  translate([52.5, 0, 23.75]) rotate([0, 0, 0]) bolt();
  translate([52.5, 0, -6.65]) rotate([0, 0, 0]) nut();
}

assembly();
