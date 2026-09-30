$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 200 x 140 mm frame, four d16 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-100, -70, 0]) cube([200, 140, 14]);
    translate([-50, -30, -1]) cube([100, 60, 16]);
    translate([-84, -54, 8]) cylinder(h = 7, d = 16.8);
    translate([84, -54, 8]) cylinder(h = 7, d = 16.8);
    translate([-84, 54, 8]) cylinder(h = 7, d = 16.8);
    translate([84, 54, 8]) cylinder(h = 7, d = 16.8);
  }
}

// --- part 2 ---
module post1() {
  cylinder(h = 60, d = 16);
}

// --- part 3 ---
module post2() {
  cylinder(h = 60, d = 16);
}

// --- part 4 ---
module post3() {
  cylinder(h = 60, d = 16);
}

// --- part 5 ---
module post4() {
  cylinder(h = 60, d = 16);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  translate([-84, -54, 8.25]) rotate([0, 0, 0]) post1();
  translate([84, -54, 8.25]) rotate([0, 0, 0]) post2();
  translate([-84, 54, 8.25]) rotate([0, 0, 0]) post3();
  translate([84, 54, 8.25]) rotate([0, 0, 0]) post4();
}

assembly();
