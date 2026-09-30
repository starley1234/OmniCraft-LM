$fn = 32;

// ------------------------------------------------------------------------
// Flange with gasket and cover: d170 flange stack, 6 bolt holes
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange() {
  difference() {
    cylinder(h = 16, d = 170);
    translate([0, 0, -1]) cylinder(h = 18, d = 80);
    translate([62.5, 0, -1]) cylinder(h = 18, d = 12.8);
    translate([31.25, 54.127, -1]) cylinder(h = 18, d = 12.8);
    translate([-31.25, 54.127, -1]) cylinder(h = 18, d = 12.8);
    translate([-62.5, 0, -1]) cylinder(h = 18, d = 12.8);
    translate([-31.25, -54.127, -1]) cylinder(h = 18, d = 12.8);
    translate([31.25, -54.127, -1]) cylinder(h = 18, d = 12.8);
  }
}

// --- part 2 ---
module gasket() {
  difference() {
    cylinder(h = 3, d = 170);
    translate([0, 0, -1]) cylinder(h = 5, d = 80);
    translate([62.5, 0, -1]) cylinder(h = 5, d = 12.8);
    translate([31.25, 54.127, -1]) cylinder(h = 5, d = 12.8);
    translate([-31.25, 54.127, -1]) cylinder(h = 5, d = 12.8);
    translate([-62.5, 0, -1]) cylinder(h = 5, d = 12.8);
    translate([-31.25, -54.127, -1]) cylinder(h = 5, d = 12.8);
    translate([31.25, -54.127, -1]) cylinder(h = 5, d = 12.8);
  }
}

// --- part 3 ---
module cover() {
  difference() {
    cylinder(h = 10, d = 170);
    translate([0, 0, -1]) cylinder(h = 12, d = 80);
    translate([62.5, 0, -1]) cylinder(h = 12, d = 12.8);
    translate([31.25, 54.127, -1]) cylinder(h = 12, d = 12.8);
    translate([-31.25, 54.127, -1]) cylinder(h = 12, d = 12.8);
    translate([-62.5, 0, -1]) cylinder(h = 12, d = 12.8);
    translate([-31.25, -54.127, -1]) cylinder(h = 12, d = 12.8);
    translate([31.25, -54.127, -1]) cylinder(h = 12, d = 12.8);
  }
}

// --- part 4 ---
module bolt() {
  cylinder(h = 8.4, d = 18);
  translate([0, 0, -53.75]) cylinder(h = 53.75, d = 12);
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
  translate([0, 0, 16.25]) rotate([0, 0, 0]) gasket();
  translate([0, 0, 19.5]) rotate([0, 0, 0]) cover();
  translate([62.5, 0, 29.75]) rotate([0, 0, 0]) bolt();
  translate([62.5, 0, -9.85]) rotate([0, 0, 0]) nut();
}

assembly();
