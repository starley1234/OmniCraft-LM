$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 140 x 140 mm frame, four d16 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-70, -70, 0]) cube([140, 140, 14]);
    translate([-32, -25, -1]) cube([64, 50, 16]);
    translate([-54, -54, 6]) cylinder(h = 9, d = 16.8);
    translate([54, -54, 6]) cylinder(h = 9, d = 16.8);
    translate([-54, 54, 6]) cylinder(h = 9, d = 16.8);
    translate([54, 54, 6]) cylinder(h = 9, d = 16.8);
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
  translate([-54, -54, 6.25]) rotate([0, 0, 0]) post1();
  translate([54, -54, 6.25]) rotate([0, 0, 0]) post2();
  translate([-54, 54, 6.25]) rotate([0, 0, 0]) post3();
  translate([54, 54, 6.25]) rotate([0, 0, 0]) post4();
}

assembly();
