$fn = 32;

// ------------------------------------------------------------------------
// Fork rocker linkage: fork 38 mm, axle d8, pin d10
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module rocker_bed() {
  difference() {
    translate([-55, -40, 0]) cube([110, 80, 12]);
  }
}

// --- part 2 ---
module rocker_fork() {
  difference() {
    union() {
      translate([-22, 13, 0]) cube([44, 12, 38]);
      translate([-22, -25, 0]) cube([44, 12, 38]);
      translate([-22, -25, 38]) cube([44, 50, 8]);
    }
    translate([0, -19, 22.8]) rotate([90, 0, 0]) cylinder(h = 14, d = 8.8, center = true);
    translate([0, 19, 22.8]) rotate([90, 0, 0]) cylinder(h = 14, d = 8.8, center = true);
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
  translate([0, 0, -33.85]) cylinder(h = 67.7, d = 8);
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
    linear_extrude(height = 6) polygon(points = [[8.66, 0], [4.33, 7.5], [-4.33, 7.5], [-8.66, 0], [-4.33, -7.5], [4.33, -7.5]]);
    translate([0, 0, -1]) cylinder(h = 8, d = 8.8);
  }
}

// --- part 8 ---
module link_fork() {
  difference() {
    translate([-15, -15, 0]) cube([30, 30, 32]);
    translate([-16, -4.4, 10]) cube([32, 8.8, 23]);
    translate([0, 0, 20.25]) rotate([90, 0, 0]) cylinder(h = 32, d = 10.8, center = true);
  }
}

// --- part 9 ---
module link_arm() {
  difference() {
    translate([-21, -4, 0]) cube([42, 8, 20]);
    translate([0, 0, 10]) rotate([90, 0, 0]) cylinder(h = 10, d = 10.8, center = true);
  }
}

// --- part 10 ---
module link_pin() {
  rotate([0, 90, 0]) cylinder(h = 40, d = 10, center = true);
  translate([-23, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 14);
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
    linear_extrude(height = 6) polygon(points = [[8.66, 0], [4.33, 7.5], [-4.33, 7.5], [-8.66, 0], [-4.33, -7.5], [4.33, -7.5]]);
    translate([0, 0, -1]) cylinder(h = 8, d = 10.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) rocker_bed();
  color([0.20, 0.45, 0.75]) translate([0, 0, 12.25]) rotate([0, 0, 0]) rocker_fork();
  color([0.25, 0.62, 0.32]) translate([0, 0, 23.05]) rotate([0, 0, 0]) rocker_arm();
  color([0.92, 0.70, 0.18]) translate([17.25, 0, 35.05]) rotate([0, 90, 0]) rocker_roller();
  color([0.58, 0.35, 0.70]) translate([0, 0, 35.05]) rotate([0, 90, 0]) rocker_axle();
  color([0.16, 0.66, 0.66]) translate([0, 26.85, 35.05]) rotate([90, 0, 0]) axle_washer();
  color([0.85, 0.48, 0.18]) translate([0, 33.1, 35.05]) rotate([90, 0, 0]) axle_nut();
  color([0.55, 0.60, 0.65]) translate([0, 0, 58.5]) rotate([0, 0, 0]) link_fork();
  color([0.75, 0.30, 0.55]) translate([0, 0, 68.75]) rotate([0, 0, 0]) link_arm();
  color([0.42, 0.52, 0.28]) translate([0, 0, 78.75]) rotate([0, 0, 90]) link_pin();
  color([0.80, 0.24, 0.20]) translate([0, 21.85, 78.75]) rotate([90, 0, 0]) pin_washer();
  color([0.20, 0.45, 0.75]) translate([0, 28.1, 78.75]) rotate([90, 0, 0]) lock_nut();
}

assembly();
