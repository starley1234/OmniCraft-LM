$fn = 32;

// ------------------------------------------------------------------------
// Frame cube: base 160 x 120 mm, posts 50 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_frame() {
  difference() {
    translate([-80, -60, 0]) cube([160, 120, 16]);
    translate([-59.6, -39.6, -1]) cube([119.2, 79.2, 18]);
    translate([-68, -48, 8]) cylinder(h = 9, d = 12.8);
    translate([68, -48, 8]) cylinder(h = 9, d = 12.8);
    translate([-68, 48, 8]) cylinder(h = 9, d = 12.8);
    translate([68, 48, 8]) cylinder(h = 9, d = 12.8);
  }
}

// --- part 2 ---
module corner_post() {
  cylinder(h = 50, d = 12);
}

// --- part 3 ---
module top_frame() {
  difference() {
    translate([-75, -55, 0]) cube([150, 110, 10]);
    translate([-59.6, -39.6, -1]) cube([119.2, 79.2, 12]);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) base_frame();
  color([0.20, 0.45, 0.75]) translate([-68, -48, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.25, 0.62, 0.32]) translate([68, -48, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.92, 0.70, 0.18]) translate([-68, 48, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.58, 0.35, 0.70]) translate([68, 48, 8.25]) rotate([0, 0, 0]) corner_post();
  color([0.16, 0.66, 0.66]) translate([0, 0, 58.5]) rotate([0, 0, 0]) top_frame();
}

assembly();
