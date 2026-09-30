$fn = 32;

// ------------------------------------------------------------------------
// Frame with four posts: 200 x 120 mm frame, four d12 posts
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-100, -60, 0]) cube([200, 120, 14]);
    translate([-40, -26, -1]) cube([80, 52, 16]);
    translate([-86, -46, 6]) cylinder(h = 9, d = 12.8);
    translate([86, -46, 6]) cylinder(h = 9, d = 12.8);
    translate([-86, 46, 6]) cylinder(h = 9, d = 12.8);
    translate([86, 46, 6]) cylinder(h = 9, d = 12.8);
  }
}

// --- part 2 ---
module post1() {
  cylinder(h = 100, d = 12);
}

// --- part 3 ---
module post2() {
  cylinder(h = 100, d = 12);
}

// --- part 4 ---
module post3() {
  cylinder(h = 100, d = 12);
}

// --- part 5 ---
module post4() {
  cylinder(h = 100, d = 12);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  translate([-86, -46, 6.25]) rotate([0, 0, 0]) post1();
  translate([86, -46, 6.25]) rotate([0, 0, 0]) post2();
  translate([-86, 46, 6.25]) rotate([0, 0, 0]) post3();
  translate([86, 46, 6.25]) rotate([0, 0, 0]) post4();
}

assembly();
