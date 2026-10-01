$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 140 x 100 mm, posts 50 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-70, -50, 0]) cube([140, 100, 16]);
    translate([-47.6, -27.6, -1]) cube([95.2, 55.2, 18]);
    translate([-58, -38, 8]) cylinder(h = 9, d = 16.8);
    translate([58, -38, 8]) cylinder(h = 9, d = 16.8);
    translate([-58, 38, 8]) cylinder(h = 9, d = 16.8);
    translate([58, 38, 8]) cylinder(h = 9, d = 16.8);
  }
}

// --- part 2 ---
module corner_post() {
  cylinder(h = 50, d = 16);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-70, -45, 0]) cube([140, 90, 12]);
    translate([-47.6, -27.6, -1]) cube([95.2, 55.2, 14]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-58, -38, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([58, -38, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-58, 38, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([58, 38, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 58.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
