$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 200 x 100 mm frame, four d12 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-100, -50, 0]) cube([200, 100, 12]);
    translate([-30, -16, -1]) cube([60, 32, 14]);
    translate([-86, -36, 4]) cylinder(h = 9, d = 12.8);
    translate([86, -36, 4]) cylinder(h = 9, d = 12.8);
    translate([-86, 36, 4]) cylinder(h = 9, d = 12.8);
    translate([86, 36, 4]) cylinder(h = 9, d = 12.8);
  }
}

// --- part 2 ---
module post1() {
  cylinder(h = 80, d = 12);
}

// --- part 3 ---
module post2() {
  cylinder(h = 80, d = 12);
}

// --- part 4 ---
module post3() {
  cylinder(h = 80, d = 12);
}

// --- part 5 ---
module post4() {
  cylinder(h = 80, d = 12);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  translate([-86, -36, 4.25]) rotate([0, 0, 0]) post1();
  translate([86, -36, 4.25]) rotate([0, 0, 0]) post2();
  translate([-86, 36, 4.25]) rotate([0, 0, 0]) post3();
  translate([86, 36, 4.25]) rotate([0, 0, 0]) post4();
}

assembly();
