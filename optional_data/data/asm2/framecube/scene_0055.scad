$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 120 x 120 mm, posts 60 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-60, -60, 0]) cube([120, 120, 16]);
    translate([-37.6, -37.6, -1]) cube([75.2, 75.2, 18]);
    translate([-46, -46, 8]) cylinder(h = 9, d = 12.8);
    translate([46, -46, 8]) cylinder(h = 9, d = 12.8);
    translate([-46, 46, 8]) cylinder(h = 9, d = 12.8);
    translate([46, 46, 8]) cylinder(h = 9, d = 12.8);
  }
}

// --- part 2 ---
module corner_post() {
  cylinder(h = 60, d = 12);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-55, -55, 0]) cube([110, 110, 10]);
    translate([-37.6, -37.6, -1]) cube([75.2, 75.2, 12]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-46, -46, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([46, -46, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-46, 46, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([46, 46, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 68.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
