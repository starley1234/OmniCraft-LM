$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 180 x 140 mm frame, four d16 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-90, -70, 0]) cube([180, 140, 12]);
    translate([-30, -30, -1]) cube([60, 60, 14]);
    translate([-74, -54, 4]) cylinder(h = 9, d = 16.8);
    translate([74, -54, 4]) cylinder(h = 9, d = 16.8);
    translate([-74, 54, 4]) cylinder(h = 9, d = 16.8);
    translate([74, 54, 4]) cylinder(h = 9, d = 16.8);
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
  translate([-74, -54, 4.25]) rotate([0, 0, 0]) post1();
  translate([74, -54, 4.25]) rotate([0, 0, 0]) post2();
  translate([-74, 54, 4.25]) rotate([0, 0, 0]) post3();
  translate([74, 54, 4.25]) rotate([0, 0, 0]) post4();
}

assembly();
