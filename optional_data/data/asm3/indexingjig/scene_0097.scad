$fn = 32;

// ------------------------------------------------------------------------
// Indexing jig: plate 120 x 70 mm, pin d10
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module jig_plate() {
  difference() {
    translate([-60, -35, 0]) cube([120, 70, 8]);
  }
}

// --- part 2 ---
module locator_block() {
  difference() {
    translate([-22, -18, 0]) cube([44, 36, 26]);
    translate([0, 0, 13]) rotate([0, 90, 0]) cylinder(h = 46, d = 10, center = true);
  }
}

// --- part 3 ---
module index_fork() {
  difference() {
    translate([-15.4, -15, 0]) cube([30.8, 30, 30]);
    translate([-16.4, -4.4, 8]) cube([32.8, 8.8, 23]);
    translate([0, 0, 19.25]) rotate([90, 0, 0]) cylinder(h = 32, d = 10.8, center = true);
  }
}

// --- part 4 ---
module index_arm() {
  difference() {
    translate([-28, -4, 0]) cube([56, 8, 22]);
    translate([0, 0, 11]) rotate([90, 0, 0]) cylinder(h = 10, d = 10.8, center = true);
  }
}

// --- part 5 ---
module index_pin() {
  rotate([0, 90, 0]) cylinder(h = 38, d = 10, center = true);
  translate([-22, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 14);
}

// --- part 6 ---
module pin_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 18);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 10.8);
    }
}

// --- part 7 ---
module lock_nut() {
  difference() {
    linear_extrude(height = 6) polygon(points = [[8.66, 0], [4.33, 7.5], [-4.33, 7.5], [-8.66, 0], [-4.33, -7.5], [4.33, -7.5]]);
    translate([0, 0, -1]) cylinder(h = 8, d = 10.8);
  }
}

// --- part 8 ---
module guide_bush_a() {
  difference() {
    union() {
      cylinder(h = 3, d = 22);
      translate([0, 0, 3]) cylinder(h = 20, d = 16);
    }
    translate([0, 0, -1]) cylinder(h = 25, d = 10.8);
  }
}

// --- part 9 ---
module guide_bush_b() {
  difference() {
    union() {
      cylinder(h = 3, d = 22);
      translate([0, 0, 3]) cylinder(h = 20, d = 16);
    }
    translate([0, 0, -1]) cylinder(h = 25, d = 10.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) jig_plate();
  color([0.20, 0.45, 0.75]) translate([26.4, 0, 8.25]) rotate([0, 0, 0]) locator_block();
  color([0.25, 0.62, 0.32]) translate([26.4, 0, 34.5]) rotate([0, 0, 0]) index_fork();
  color([0.92, 0.70, 0.18]) translate([26.4, 0, 42.75]) rotate([0, 0, 0]) index_arm();
  color([0.58, 0.35, 0.70]) translate([26.4, 0, 53.75]) rotate([0, 0, 90]) index_pin();
  color([0.16, 0.66, 0.66]) translate([26.4, 20.85, 53.75]) rotate([90, 0, 0]) pin_washer();
  color([0.85, 0.48, 0.18]) translate([26.4, 27.1, 53.75]) rotate([90, 0, 0]) lock_nut();
  color([0.55, 0.60, 0.65]) translate([-36, -19.6, 8.25]) rotate([0, 0, 0]) guide_bush_a();
  color([0.75, 0.30, 0.55]) translate([-36, 19.6, 8.25]) rotate([0, 0, 0]) guide_bush_b();
}

assembly();
