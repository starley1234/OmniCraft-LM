$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 160 x 100 mm frame, four d20 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-80, -50, 0]) cube([160, 100, 12]);
    translate([-38, -12, -1]) cube([76, 24, 14]);
    translate([-62, -32, 6]) cylinder(h = 7, d = 20.8);
    translate([62, -32, 6]) cylinder(h = 7, d = 20.8);
    translate([-62, 32, 6]) cylinder(h = 7, d = 20.8);
    translate([62, 32, 6]) cylinder(h = 7, d = 20.8);
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
  translate([-62, -32, 6.25]) rotate([0, 0, 0]) post1();
  translate([62, -32, 6.25]) rotate([0, 0, 0]) post2();
  translate([-62, 32, 6.25]) rotate([0, 0, 0]) post3();
  translate([62, 32, 6.25]) rotate([0, 0, 0]) post4();
}

assembly();
