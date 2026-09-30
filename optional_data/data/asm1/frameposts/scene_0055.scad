$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 140 x 140 mm frame, four d20 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-70, -70, 0]) cube([140, 140, 12]);
    translate([-28, -20, -1]) cube([56, 40, 14]);
    translate([-52, -52, 4]) cylinder(h = 9, d = 20.8);
    translate([52, -52, 4]) cylinder(h = 9, d = 20.8);
    translate([-52, 52, 4]) cylinder(h = 9, d = 20.8);
    translate([52, 52, 4]) cylinder(h = 9, d = 20.8);
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
  translate([-52, -52, 4.25]) rotate([0, 0, 0]) post1();
  translate([52, -52, 4.25]) rotate([0, 0, 0]) post2();
  translate([-52, 52, 4.25]) rotate([0, 0, 0]) post3();
  translate([52, 52, 4.25]) rotate([0, 0, 0]) post4();
}

assembly();
