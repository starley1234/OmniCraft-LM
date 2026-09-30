$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 180 x 140 mm frame, four d12 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-90, -70, 0]) cube([180, 140, 10]);
    translate([-55, -25, -1]) cube([110, 50, 12]);
    translate([-76, -56, 3]) cylinder(h = 8, d = 12.8);
    translate([76, -56, 3]) cylinder(h = 8, d = 12.8);
    translate([-76, 56, 3]) cylinder(h = 8, d = 12.8);
    translate([76, 56, 3]) cylinder(h = 8, d = 12.8);
  }
}

// --- part 2 ---
module post1() {
  cylinder(h = 100, d = 12);
}

// --- part 3 ---
module post2() {
  cylinder(h = 100, d = 12);
}

// --- part 4 ---
module post3() {
  cylinder(h = 100, d = 12);
}

// --- part 5 ---
module post4() {
  cylinder(h = 100, d = 12);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  translate([-76, -56, 3.25]) rotate([0, 0, 0]) post1();
  translate([76, -56, 3.25]) rotate([0, 0, 0]) post2();
  translate([-76, 56, 3.25]) rotate([0, 0, 0]) post3();
  translate([76, 56, 3.25]) rotate([0, 0, 0]) post4();
}

assembly();
