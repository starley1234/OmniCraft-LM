$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 180 x 120 mm frame, four d20 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-90, -60, 0]) cube([180, 120, 14]);
    translate([-48, -18, -1]) cube([96, 36, 16]);
    translate([-72, -42, 6]) cylinder(h = 9, d = 20.8);
    translate([72, -42, 6]) cylinder(h = 9, d = 20.8);
    translate([-72, 42, 6]) cylinder(h = 9, d = 20.8);
    translate([72, 42, 6]) cylinder(h = 9, d = 20.8);
  }
}

// --- part 2 ---
module post1() {
  cylinder(h = 100, d = 20);
}

// --- part 3 ---
module post2() {
  cylinder(h = 100, d = 20);
}

// --- part 4 ---
module post3() {
  cylinder(h = 100, d = 20);
}

// --- part 5 ---
module post4() {
  cylinder(h = 100, d = 20);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  translate([-72, -42, 6.25]) rotate([0, 0, 0]) post1();
  translate([72, -42, 6.25]) rotate([0, 0, 0]) post2();
  translate([-72, 42, 6.25]) rotate([0, 0, 0]) post3();
  translate([72, 42, 6.25]) rotate([0, 0, 0]) post4();
}

assembly();
