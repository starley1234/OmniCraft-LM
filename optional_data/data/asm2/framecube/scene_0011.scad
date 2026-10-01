$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 120 x 90 mm, posts 100 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-60, -45, 0]) cube([120, 90, 14]);
    translate([-33.6, -18.6, -1]) cube([67.2, 37.2, 16]);
    translate([-44, -29, 7]) cylinder(h = 8, d = 16.8);
    translate([44, -29, 7]) cylinder(h = 8, d = 16.8);
    translate([-44, 29, 7]) cylinder(h = 8, d = 16.8);
    translate([44, 29, 7]) cylinder(h = 8, d = 16.8);
  }
}

// --- part 2 ---
module corner_post() {
  cylinder(h = 100, d = 16);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-55, -40, 0]) cube([110, 80, 10]);
    translate([-33.6, -18.6, -1]) cube([67.2, 37.2, 12]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-44, -29, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([44, -29, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-44, 29, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([44, 29, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 107.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
