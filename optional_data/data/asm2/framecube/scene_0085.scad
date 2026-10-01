$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 140 x 120 mm, posts 50 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-70, -60, 0]) cube([140, 120, 12]);
    translate([-45.7, -35.7, -1]) cube([91.4, 71.4, 14]);
    translate([-58, -48, 6]) cylinder(h = 7, d = 20.6);
    translate([58, -48, 6]) cylinder(h = 7, d = 20.6);
    translate([-58, 48, 6]) cylinder(h = 7, d = 20.6);
    translate([58, 48, 6]) cylinder(h = 7, d = 20.6);
  }
}

// --- part 2 ---
module corner_post() {
  translate([-7, -7, 0]) cube([14, 14, 50]);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-65, -55, 0]) cube([130, 110, 12]);
    translate([-45.7, -35.7, -1]) cube([91.4, 71.4, 14]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-58, -48, 6.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([58, -48, 6.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-58, 48, 6.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([58, 48, 6.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 56.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
