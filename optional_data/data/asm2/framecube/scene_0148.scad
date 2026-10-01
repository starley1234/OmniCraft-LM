$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 160 x 120 mm, posts 60 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-80, -60, 0]) cube([160, 120, 16]);
    translate([-52.285, -32.285, -1]) cube([104.57, 64.57, 18]);
    translate([-66, -46, 8]) cylinder(h = 9, d = 23.43);
    translate([66, -46, 8]) cylinder(h = 9, d = 23.43);
    translate([-66, 46, 8]) cylinder(h = 9, d = 23.43);
    translate([66, 46, 8]) cylinder(h = 9, d = 23.43);
  }
}

// --- part 2 ---
module corner_post() {
  translate([-8, -8, 0]) cube([16, 16, 60]);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-75, -55, 0]) cube([150, 110, 12]);
    translate([-52.285, -32.285, -1]) cube([104.57, 64.57, 14]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-66, -46, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([66, -46, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-66, 46, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([66, 46, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 68.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
