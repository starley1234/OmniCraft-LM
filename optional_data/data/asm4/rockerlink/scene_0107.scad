$fn = 32;

// ------------------------------------------------------------------------
// Fork rocker linkage: fork 46 mm, axle d10, pin d8
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module rocker_bed() {
  difference() {
    translate([-55, -35, 0]) cube([110, 70, 12]);
  }
}

// --- part 2 ---
module rocker_fork() {
  difference() {
    union() {
      translate([-20, 15, 0]) cube([40, 10, 46]);
      translate([-20, -25, 0]) cube([40, 10, 46]);
      translate([-20, -25, 46]) cube([40, 50, 10]);
    }
    translate([0, -20, 27.6]) rotate([90, 0, 0]) cylinder(h = 12, d = 10.8, center = true);
    translate([0, 20, 27.6]) rotate([90, 0, 0]) cylinder(h = 12, d = 10.8, center = true);
  }
}

// --- part 3 ---
module rocker_arm() {
  difference() {
    translate([-17, -9, 0]) cube([34, 18, 26]);
    translate([0, 0, 13]) rotate([0, 90, 0]) cylinder(h = 36, d = 10.8, center = true);
  }
}

// --- part 4 ---
module rocker_roller() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 22);
      translate([0, 0, -1]) cylinder(h = 12, d = 10.8);
    }
}

// --- part 5 ---
module rocker_axle() {
  translate([0, 0, -34.85]) cylinder(h = 69.7, d = 10);
}

// --- part 6 ---
module axle_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 16);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 10.8);
    }
}

// --- part 7 ---
module axle_nut() {
  difference() {
    linear_extrude(height = 7) polygon(points = [[7.506, 0], [3.753, 6.5], [-3.753, 6.5], [-7.506, 0], [-3.753, -6.5], [3.753, -6.5]]);
    translate([0, 0, -1]) cylinder(h = 9, d = 10.8);
  }
}

// --- part 8 ---
module link_fork() {
  difference() {
    translate([-15, -15, 0]) cube([30, 30, 34]);
    translate([-16, -5.4, 8]) cube([32, 10.8, 27]);
    translate([0, 0, 18.25]) rotate([90, 0, 0]) cylinder(h = 32, d = 8.8, center = true);
  }
}

// --- part 9 ---
module link_arm() {
  difference() {
    translate([-21, -5, 0]) cube([42, 10, 20]);
    translate([0, 0, 10]) rotate([90, 0, 0]) cylinder(h = 12, d = 8.8, center = true);
  }
}

// --- part 10 ---
module link_pin() {
  rotate([0, 90, 0]) cylinder(h = 36, d = 8, center = true);
  translate([-21, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 12);
}

// --- part 11 ---
module pin_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 16);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 8.8);
    }
}

// --- part 12 ---
module lock_nut() {
  difference() {
    linear_extrude(height = 7) polygon(points = [[7.506, 0], [3.753, 6.5], [-3.753, 6.5], [-7.506, 0], [-3.753, -6.5], [3.753, -6.5]]);
    translate([0, 0, -1]) cylinder(h = 9, d = 8.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) rocker_bed();
  color([0.20, 0.45, 0.75]) translate([0, 0, 12.25]) rotate([0, 0, 0]) rocker_fork();
  color([0.25, 0.62, 0.32]) translate([0, 0, 26.85]) rotate([0, 0, 0]) rocker_arm();
  color([0.92, 0.70, 0.18]) translate([17.25, 0, 39.85]) rotate([0, 90, 0]) rocker_roller();
  color([0.58, 0.35, 0.70]) translate([0, 0, 39.85]) rotate([0, 90, 0]) rocker_axle();
  color([0.16, 0.66, 0.66]) translate([0, 26.85, 39.85]) rotate([90, 0, 0]) axle_washer();
  color([0.85, 0.48, 0.18]) translate([0, 34.1, 39.85]) rotate([90, 0, 0]) axle_nut();
  color([0.55, 0.60, 0.65]) translate([0, 0, 68.5]) rotate([0, 0, 0]) link_fork();
  color([0.75, 0.30, 0.55]) translate([0, 0, 76.75]) rotate([0, 0, 0]) link_arm();
  color([0.42, 0.52, 0.28]) translate([0, 0, 86.75]) rotate([0, 0, 90]) link_pin();
  color([0.80, 0.24, 0.20]) translate([0, 19.85, 86.75]) rotate([90, 0, 0]) pin_washer();
  color([0.20, 0.45, 0.75]) translate([0, 27.1, 86.75]) rotate([90, 0, 0]) lock_nut();
}

assembly();
