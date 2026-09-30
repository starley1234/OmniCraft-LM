$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 180 x 100 mm frame, four d16 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-90, -50, 0]) cube([180, 100, 14]);
    translate([-30, -12, -1]) cube([60, 24, 16]);
    translate([-74, -34, 6]) cylinder(h = 9, d = 16.8);
    translate([74, -34, 6]) cylinder(h = 9, d = 16.8);
    translate([-74, 34, 6]) cylinder(h = 9, d = 16.8);
    translate([74, 34, 6]) cylinder(h = 9, d = 16.8);
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
  translate([-74, -34, 6.25]) rotate([0, 0, 0]) post1();
  translate([74, -34, 6.25]) rotate([0, 0, 0]) post2();
  translate([-74, 34, 6.25]) rotate([0, 0, 0]) post3();
  translate([74, 34, 6.25]) rotate([0, 0, 0]) post4();
}

assembly();
