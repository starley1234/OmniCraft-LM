$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 160 x 90 mm, posts 100 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-80, -45, 0]) cube([160, 90, 12]);
    translate([-53.115, -18.115, -1]) cube([106.23, 36.23, 14]);
    translate([-64, -29, 6]) cylinder(h = 7, d = 17.77);
    translate([64, -29, 6]) cylinder(h = 7, d = 17.77);
    translate([-64, 29, 6]) cylinder(h = 7, d = 17.77);
    translate([64, 29, 6]) cylinder(h = 7, d = 17.77);
  }
}

// --- part 2 ---
module corner_post() {
  translate([-6, -6, 0]) cube([12, 12, 100]);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-80, -45, 0]) cube([160, 90, 10]);
    translate([-53.115, -18.115, -1]) cube([106.23, 36.23, 12]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-64, -29, 6.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([64, -29, 6.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-64, 29, 6.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([64, 29, 6.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 106.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
