$fn = 32;

// ------------------------------------------------------------------------
// Fork rocker linkage: fork 40 mm, axle d8, pin d10
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module rocker_bed() {
  difference() {
    translate([-55, -35, 0]) cube([110, 70, 10]);
  }
}

// --- part 2 ---
module rocker_fork() {
  difference() {
    union() {
      translate([-20, 15, 0]) cube([40, 12, 40]);
      translate([-20, -27, 0]) cube([40, 12, 40]);
      translate([-20, -27, 40]) cube([40, 54, 8]);
    }
    translate([0, -21, 24]) rotate([90, 0, 0]) cylinder(h = 14, d = 8.8, center = true);
    translate([0, 21, 24]) rotate([90, 0, 0]) cylinder(h = 14, d = 8.8, center = true);
  }
}

// --- part 3 ---
module rocker_arm() {
  difference() {
    translate([-17, -9, 0]) cube([34, 18, 24]);
    translate([0, 0, 12]) rotate([0, 90, 0]) cylinder(h = 36, d = 8.8, center = true);
  }
}

// --- part 4 ---
module rocker_roller() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 8, d = 22);
      translate([0, 0, -1]) cylinder(h = 10, d = 8.8);
    }
}

// --- part 5 ---
module rocker_axle() {
  translate([0, 0, -36.85]) cylinder(h = 73.7, d = 8);
}

// --- part 6 ---
module axle_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 18);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 8.8);
    }
}

// --- part 7 ---
module axle_nut() {
  difference() {
    linear_extrude(height = 7) polygon(points = [[8.66, 0], [4.33, 7.5], [-4.33, 7.5], [-8.66, 0], [-4.33, -7.5], [4.33, -7.5]]);
    translate([0, 0, -1]) cylinder(h = 9, d = 8.8);
  }
}

// --- part 8 ---
module link_fork() {
  difference() {
    translate([-15, -15, 0]) cube([30, 30, 30]);
    translate([-16, -5.4, 10]) cube([32, 10.8, 21]);
    translate([0, 0, 21.25]) rotate([90, 0, 0]) cylinder(h = 32, d = 10.8, center = true);
  }
}

// --- part 9 ---
module link_arm() {
  difference() {
    translate([-21, -5, 0]) cube([42, 10, 22]);
    translate([0, 0, 11]) rotate([90, 0, 0]) cylinder(h = 12, d = 10.8, center = true);
  }
}

// --- part 10 ---
module link_pin() {
  rotate([0, 90, 0]) cylinder(h = 36, d = 10, center = true);
  translate([-21, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 14);
}

// --- part 11 ---
module pin_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 18);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 10.8);
    }
}

// --- part 12 ---
module lock_nut() {
  difference() {
    linear_extrude(height = 7) polygon(points = [[8.66, 0], [4.33, 7.5], [-4.33, 7.5], [-8.66, 0], [-4.33, -7.5], [4.33, -7.5]]);
    translate([0, 0, -1]) cylinder(h = 9, d = 10.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) rocker_bed();
  color([0.20, 0.45, 0.75]) translate([0, 0, 10.25]) rotate([0, 0, 0]) rocker_fork();
  color([0.25, 0.62, 0.32]) translate([0, 0, 22.25]) rotate([0, 0, 0]) rocker_arm();
  color([0.92, 0.70, 0.18]) translate([17.25, 0, 34.25]) rotate([0, 90, 0]) rocker_roller();
  color([0.58, 0.35, 0.70]) translate([0, 0, 34.25]) rotate([0, 90, 0]) rocker_axle();
  color([0.16, 0.66, 0.66]) translate([0, 28.85, 34.25]) rotate([90, 0, 0]) axle_washer();
  color([0.85, 0.48, 0.18]) translate([0, 36.1, 34.25]) rotate([90, 0, 0]) axle_nut();
  color([0.55, 0.60, 0.65]) translate([0, 0, 58.5]) rotate([0, 0, 0]) link_fork();
  color([0.75, 0.30, 0.55]) translate([0, 0, 68.75]) rotate([0, 0, 0]) link_arm();
  color([0.42, 0.52, 0.28]) translate([0, 0, 79.75]) rotate([0, 0, 90]) link_pin();
  color([0.80, 0.24, 0.20]) translate([0, 19.85, 79.75]) rotate([90, 0, 0]) pin_washer();
  color([0.20, 0.45, 0.75]) translate([0, 27.1, 79.75]) rotate([90, 0, 0]) lock_nut();
}

assembly();
