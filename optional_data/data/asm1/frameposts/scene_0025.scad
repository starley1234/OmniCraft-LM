$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 160 x 120 mm frame, four d16 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-80, -60, 0]) cube([160, 120, 10]);
    translate([-42, -22, -1]) cube([84, 44, 12]);
    translate([-64, -44, 3]) cylinder(h = 8, d = 16.8);
    translate([64, -44, 3]) cylinder(h = 8, d = 16.8);
    translate([-64, 44, 3]) cylinder(h = 8, d = 16.8);
    translate([64, 44, 3]) cylinder(h = 8, d = 16.8);
  }
}

// --- part 2 ---
module post1() {
  cylinder(h = 100, d = 16);
}

// --- part 3 ---
module post2() {
  cylinder(h = 100, d = 16);
}

// --- part 4 ---
module post3() {
  cylinder(h = 100, d = 16);
}

// --- part 5 ---
module post4() {
  cylinder(h = 100, d = 16);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  translate([-64, -44, 3.25]) rotate([0, 0, 0]) post1();
  translate([64, -44, 3.25]) rotate([0, 0, 0]) post2();
  translate([-64, 44, 3.25]) rotate([0, 0, 0]) post3();
  translate([64, 44, 3.25]) rotate([0, 0, 0]) post4();
}

assembly();
