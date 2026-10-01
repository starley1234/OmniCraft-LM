$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 120 x 90 mm, posts 80 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-60, -45, 0]) cube([120, 90, 16]);
    translate([-35.7, -20.7, -1]) cube([71.4, 41.4, 18]);
    translate([-48, -33, 8]) cylinder(h = 9, d = 20.6);
    translate([48, -33, 8]) cylinder(h = 9, d = 20.6);
    translate([-48, 33, 8]) cylinder(h = 9, d = 20.6);
    translate([48, 33, 8]) cylinder(h = 9, d = 20.6);
  }
}

// --- part 2 ---
module corner_post() {
  translate([-7, -7, 0]) cube([14, 14, 80]);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-55, -45, 0]) cube([110, 90, 12]);
    translate([-35.7, -20.7, -1]) cube([71.4, 41.4, 14]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-48, -33, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([48, -33, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-48, 33, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([48, 33, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 88.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
