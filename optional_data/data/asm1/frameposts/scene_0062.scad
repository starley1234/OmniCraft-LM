$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 140 x 100 mm frame, four d16 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-70, -50, 0]) cube([140, 100, 10]);
    translate([-32, -12, -1]) cube([64, 24, 12]);
    translate([-54, -34, 3]) cylinder(h = 8, d = 16.8);
    translate([54, -34, 3]) cylinder(h = 8, d = 16.8);
    translate([-54, 34, 3]) cylinder(h = 8, d = 16.8);
    translate([54, 34, 3]) cylinder(h = 8, d = 16.8);
  }
}

// --- part 2 ---
module post1() {
  cylinder(h = 40, d = 16);
}

// --- part 3 ---
module post2() {
  cylinder(h = 40, d = 16);
}

// --- part 4 ---
module post3() {
  cylinder(h = 40, d = 16);
}

// --- part 5 ---
module post4() {
  cylinder(h = 40, d = 16);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  translate([-54, -34, 3.25]) rotate([0, 0, 0]) post1();
  translate([54, -34, 3.25]) rotate([0, 0, 0]) post2();
  translate([-54, 34, 3.25]) rotate([0, 0, 0]) post3();
  translate([54, 34, 3.25]) rotate([0, 0, 0]) post4();
}

assembly();
