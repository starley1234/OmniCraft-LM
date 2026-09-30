$fn = 32;

// ------------------------------------------------------------------------
// Flange with gasket and cover: d150 flange stack, 4 bolt holes
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange() {
  difference() {
    cylinder(h = 16, d = 150);
    translate([0, 0, -1]) cylinder(h = 18, d = 50);
    translate([50, 0, -1]) cylinder(h = 18, d = 8.8);
    translate([0, 50, -1]) cylinder(h = 18, d = 8.8);
    translate([-50, 0, -1]) cylinder(h = 18, d = 8.8);
    translate([0, -50, -1]) cylinder(h = 18, d = 8.8);
  }
}

// --- part 2 ---
module gasket() {
  difference() {
    cylinder(h = 3, d = 150);
    translate([0, 0, -1]) cylinder(h = 5, d = 50);
    translate([50, 0, -1]) cylinder(h = 5, d = 8.8);
    translate([0, 50, -1]) cylinder(h = 5, d = 8.8);
    translate([-50, 0, -1]) cylinder(h = 5, d = 8.8);
    translate([0, -50, -1]) cylinder(h = 5, d = 8.8);
  }
}

// --- part 3 ---
module cover() {
  difference() {
    cylinder(h = 10, d = 150);
    translate([0, 0, -1]) cylinder(h = 12, d = 50);
    translate([50, 0, -1]) cylinder(h = 12, d = 8.8);
    translate([0, 50, -1]) cylinder(h = 12, d = 8.8);
    translate([-50, 0, -1]) cylinder(h = 12, d = 8.8);
    translate([0, -50, -1]) cylinder(h = 12, d = 8.8);
  }
}

// --- part 4 ---
module bolt() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -53.75]) cylinder(h = 53.75, d = 8);
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
  translate([0, 0, 16.25]) rotate([0, 0, 0]) gasket();
  translate([0, 0, 19.5]) rotate([0, 0, 0]) cover();
  translate([50, 0, 29.75]) rotate([0, 0, 0]) bolt();
  translate([50, 0, -6.65]) rotate([0, 0, 0]) nut();
}

assembly();
