$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 180 x 100 mm frame, four d20 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-90, -50, 0]) cube([180, 100, 10]);
    translate([-48, -12, -1]) cube([96, 24, 12]);
    translate([-72, -32, 3]) cylinder(h = 8, d = 20.8);
    translate([72, -32, 3]) cylinder(h = 8, d = 20.8);
    translate([-72, 32, 3]) cylinder(h = 8, d = 20.8);
    translate([72, 32, 3]) cylinder(h = 8, d = 20.8);
  }
}

// --- part 2 ---
module post1() {
  cylinder(h = 40, d = 20);
}

// --- part 3 ---
module post2() {
  cylinder(h = 40, d = 20);
}

// --- part 4 ---
module post3() {
  cylinder(h = 40, d = 20);
}

// --- part 5 ---
module post4() {
  cylinder(h = 40, d = 20);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  translate([-72, -32, 3.25]) rotate([0, 0, 0]) post1();
  translate([72, -32, 3.25]) rotate([0, 0, 0]) post2();
  translate([-72, 32, 3.25]) rotate([0, 0, 0]) post3();
  translate([72, 32, 3.25]) rotate([0, 0, 0]) post4();
}

assembly();
