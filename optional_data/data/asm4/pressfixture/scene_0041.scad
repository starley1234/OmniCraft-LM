$fn = 32;

// ------------------------------------------------------------------------
// Arbor press fixture: screw d10, posts 70 mm, gap 16 mm
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module press_bed() {
  difference() {
    translate([-65, -45, 0]) cube([130, 90, 12]);
  }
}

// --- part 2 ---
module anvil_block() {
  difference() {
    translate([-22, -20, 0]) cube([44, 40, 20]);
    translate([0, 0, 10]) rotate([0, 90, 0]) cylinder(h = 46, d = 12, center = true);
  }
}

// --- part 3 ---
module press_post_a() {
  translate([-9, -9, 0]) cube([18, 18, 70]);
}

// --- part 4 ---
module press_post_b() {
  translate([-9, -9, 0]) cube([18, 18, 70]);
}

// --- part 5 ---
module press_post_c() {
  translate([-9, -9, 0]) cube([18, 18, 70]);
}

// --- part 6 ---
module press_post_d() {
  translate([-9, -9, 0]) cube([18, 18, 70]);
}

// --- part 7 ---
module press_frame() {
  difference() {
    translate([-61, -41, 0]) cube([122, 82, 12]);
    translate([-13, -13, -1]) cube([26, 26, 14]);
    translate([50, 30, 7]) cylinder(h = 6, d = 18.8);
    translate([50, -30, 7]) cylinder(h = 6, d = 18.8);
    translate([-50, 30, 7]) cylinder(h = 6, d = 18.8);
    translate([-50, -30, 7]) cylinder(h = 6, d = 18.8);
  }
}

// --- part 8 ---
module guide_ring() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 14, d = 38);
      translate([0, 0, -1]) cylinder(h = 16, d = 10.8);
    }
}

// --- part 9 ---
module press_screw() {
  translate([0, 0, -33.3]) cylinder(h = 66.6, d = 10);
}

// --- part 10 ---
module press_head() {
  difference() {
    cylinder(h = 16, d = 32);
    translate([0, 0, -1]) cylinder(h = 18, d = 10.8);
    translate([0, 0, 8]) rotate([90, 0, 0]) cylinder(h = 34, d = 4, center = true);
  }
}

// --- part 11 ---
module nut_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 20);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 10.8);
    }
}

// --- part 12 ---
module press_nut() {
  difference() {
    linear_extrude(height = 8) polygon(points = [[9.238, 0], [4.619, 8], [-4.619, 8], [-9.238, 0], [-4.619, -8], [4.619, -8]]);
    translate([0, 0, -1]) cylinder(h = 10, d = 10.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) press_bed();
  color([0.20, 0.45, 0.75]) translate([0, 0, 12.25]) rotate([0, 0, 0]) anvil_block();
  color([0.25, 0.62, 0.32]) translate([50, 30, 12.25]) rotate([0, 0, 0]) press_post_a();
  color([0.92, 0.70, 0.18]) translate([50, -30, 12.25]) rotate([0, 0, 0]) press_post_b();
  color([0.58, 0.35, 0.70]) translate([-50, 30, 12.25]) rotate([0, 0, 0]) press_post_c();
  color([0.16, 0.66, 0.66]) translate([-50, -30, 12.25]) rotate([0, 0, 0]) press_post_d();
  color([0.85, 0.48, 0.18]) translate([0, 0, 82.5]) rotate([0, 0, 0]) press_frame();
  color([0.55, 0.60, 0.65]) translate([0, 0, 94.75]) rotate([0, 0, 0]) guide_ring();
  color([0.75, 0.30, 0.55]) translate([0, 0, 83.55]) rotate([0, 0, 0]) press_screw();
  color([0.42, 0.52, 0.28]) translate([0, 0, 48.25]) rotate([0, 0, 0]) press_head();
  color([0.80, 0.24, 0.20]) translate([0, 0, 109]) rotate([0, 0, 0]) nut_washer();
  color([0.20, 0.45, 0.75]) translate([0, 0, 110.85]) rotate([0, 0, 0]) press_nut();
}

assembly();
