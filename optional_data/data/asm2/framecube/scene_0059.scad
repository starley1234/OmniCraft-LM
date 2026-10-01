$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 120 x 90 mm, posts 100 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-60, -45, 0]) cube([120, 90, 14]);
    translate([-34.285, -19.285, -1]) cube([68.57, 38.57, 16]);
    translate([-48, -33, 7]) cylinder(h = 8, d = 23.43);
    translate([48, -33, 7]) cylinder(h = 8, d = 23.43);
    translate([-48, 33, 7]) cylinder(h = 8, d = 23.43);
    translate([48, 33, 7]) cylinder(h = 8, d = 23.43);
  }
}

// --- part 2 ---
module corner_post() {
  translate([-8, -8, 0]) cube([16, 16, 100]);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-55, -40, 0]) cube([110, 80, 10]);
    translate([-34.285, -19.285, -1]) cube([68.57, 38.57, 12]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-48, -33, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([48, -33, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-48, 33, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([48, 33, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 107.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
