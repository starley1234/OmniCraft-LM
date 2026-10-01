$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 140 x 90 mm, posts 80 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-70, -45, 0]) cube([140, 90, 16]);
    translate([-49.6, -24.6, -1]) cube([99.2, 49.2, 18]);
    translate([-58, -33, 8]) cylinder(h = 9, d = 12.8);
    translate([58, -33, 8]) cylinder(h = 9, d = 12.8);
    translate([-58, 33, 8]) cylinder(h = 9, d = 12.8);
    translate([58, 33, 8]) cylinder(h = 9, d = 12.8);
  }
}

// --- part 2 ---
module corner_post() {
  cylinder(h = 80, d = 12);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-65, -45, 0]) cube([130, 90, 10]);
    translate([-49.6, -24.6, -1]) cube([99.2, 49.2, 12]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-58, -33, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([58, -33, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-58, 33, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([58, 33, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 88.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
