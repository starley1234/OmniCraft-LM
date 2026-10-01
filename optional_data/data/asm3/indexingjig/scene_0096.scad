$fn = 32;

// ------------------------------------------------------------------------
// Indexing jig: plate 100 x 60 mm, pin d8
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module jig_plate() {
  difference() {
    translate([-50, -30, 0]) cube([100, 60, 12]);
  }
}

// --- part 2 ---
module locator_block() {
  difference() {
    translate([-20, -18, 0]) cube([40, 36, 30]);
    translate([0, 0, 15]) rotate([0, 90, 0]) cylinder(h = 42, d = 10, center = true);
  }
}

// --- part 3 ---
module index_fork() {
  difference() {
    translate([-13.75, -15, 0]) cube([27.5, 30, 28]);
    translate([-14.75, -5.4, 10]) cube([29.5, 10.8, 19]);
    translate([0, 0, 21.25]) rotate([90, 0, 0]) cylinder(h = 32, d = 8.8, center = true);
  }
}

// --- part 4 ---
module index_arm() {
  difference() {
    translate([-25, -5, 0]) cube([50, 10, 22]);
    translate([0, 0, 11]) rotate([90, 0, 0]) cylinder(h = 12, d = 8.8, center = true);
  }
}

// --- part 5 ---
module index_pin() {
  rotate([0, 90, 0]) cylinder(h = 34, d = 8, center = true);
  translate([-20, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 12);
}

// --- part 6 ---
module pin_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 16);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 8.8);
    }
}

// --- part 7 ---
module lock_nut() {
  difference() {
    linear_extrude(height = 6) polygon(points = [[7.506, 0], [3.753, 6.5], [-3.753, 6.5], [-7.506, 0], [-3.753, -6.5], [3.753, -6.5]]);
    translate([0, 0, -1]) cylinder(h = 8, d = 8.8);
  }
}

// --- part 8 ---
module guide_bush_a() {
  difference() {
    union() {
      cylinder(h = 3, d = 24);
      translate([0, 0, 3]) cylinder(h = 22, d = 18);
    }
    translate([0, 0, -1]) cylinder(h = 27, d = 8.8);
  }
}

// --- part 9 ---
module guide_bush_b() {
  difference() {
    union() {
      cylinder(h = 3, d = 24);
      translate([0, 0, 3]) cylinder(h = 22, d = 18);
    }
    translate([0, 0, -1]) cylinder(h = 27, d = 8.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) jig_plate();
  color([0.20, 0.45, 0.75]) translate([-22, 0, 12.25]) rotate([0, 0, 0]) locator_block();
  color([0.25, 0.62, 0.32]) translate([-22, 0, 42.5]) rotate([0, 0, 0]) index_fork();
  color([0.92, 0.70, 0.18]) translate([-22, 0, 52.75]) rotate([0, 0, 0]) index_arm();
  color([0.58, 0.35, 0.70]) translate([-22, 0, 63.75]) rotate([0, 0, 90]) index_pin();
  color([0.16, 0.66, 0.66]) translate([-22, 18.85, 63.75]) rotate([90, 0, 0]) pin_washer();
  color([0.85, 0.48, 0.18]) translate([-22, 25.1, 63.75]) rotate([90, 0, 0]) lock_nut();
  color([0.55, 0.60, 0.65]) translate([30, -16.8, 12.25]) rotate([0, 0, 0]) guide_bush_a();
  color([0.75, 0.30, 0.55]) translate([30, 16.8, 12.25]) rotate([0, 0, 0]) guide_bush_b();
}

assembly();
