$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 160 x 100 mm, posts 80 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-80, -50, 0]) cube([160, 100, 14]);
    translate([-57.115, -27.115, -1]) cube([114.23, 54.23, 16]);
    translate([-68, -38, 7]) cylinder(h = 8, d = 17.77);
    translate([68, -38, 7]) cylinder(h = 8, d = 17.77);
    translate([-68, 38, 7]) cylinder(h = 8, d = 17.77);
    translate([68, 38, 7]) cylinder(h = 8, d = 17.77);
  }
}

// --- part 2 ---
module corner_post() {
  translate([-6, -6, 0]) cube([12, 12, 80]);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-75, -50, 0]) cube([150, 100, 10]);
    translate([-57.115, -27.115, -1]) cube([114.23, 54.23, 12]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-68, -38, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([68, -38, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-68, 38, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([68, 38, 7.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 87.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
