$fn = 32;

// ------------------------------------------------------------------------
// Fork rocker linkage: fork 38 mm, axle d8, pin d10
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module rocker_bed() {
  difference() {
    translate([-60, -40, 0]) cube([120, 80, 10]);
  }
}

// --- part 2 ---
module rocker_fork() {
  difference() {
    union() {
      translate([-22, 15, 0]) cube([44, 10, 38]);
      translate([-22, -25, 0]) cube([44, 10, 38]);
      translate([-22, -25, 38]) cube([44, 50, 10]);
    }
    translate([0, -20, 22.8]) rotate([90, 0, 0]) cylinder(h = 12, d = 8.8, center = true);
    translate([0, 20, 22.8]) rotate([90, 0, 0]) cylinder(h = 12, d = 8.8, center = true);
  }
}

// --- part 3 ---
module rocker_arm() {
  difference() {
    translate([-15, -10, 0]) cube([30, 20, 26]);
    translate([0, 0, 13]) rotate([0, 90, 0]) cylinder(h = 32, d = 8.8, center = true);
  }
}

// --- part 4 ---
module rocker_roller() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 20);
      translate([0, 0, -1]) cylinder(h = 12, d = 8.8);
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
    translate([-13, -15, 0]) cube([26, 30, 34]);
    translate([-14, -4.4, 8]) cube([28, 8.8, 27]);
    translate([0, 0, 19.25]) rotate([90, 0, 0]) cylinder(h = 32, d = 10.8, center = true);
  }
}

// --- part 9 ---
module link_arm() {
  difference() {
    translate([-19, -4, 0]) cube([38, 8, 22]);
    translate([0, 0, 11]) rotate([90, 0, 0]) cylinder(h = 10, d = 10.8, center = true);
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
  color([0.20, 0.45, 0.75]) translate([0, 0, 10.25]) rotate([0, 0, 0]) rocker_fork();
  color([0.25, 0.62, 0.32]) translate([0, 0, 20.05]) rotate([0, 0, 0]) rocker_arm();
  color([0.92, 0.70, 0.18]) translate([15.25, 0, 33.05]) rotate([0, 90, 0]) rocker_roller();
  color([0.58, 0.35, 0.70]) translate([0, 0, 33.05]) rotate([0, 90, 0]) rocker_axle();
  color([0.16, 0.66, 0.66]) translate([0, 26.85, 33.05]) rotate([90, 0, 0]) axle_washer();
  color([0.85, 0.48, 0.18]) translate([0, 33.1, 33.05]) rotate([90, 0, 0]) axle_nut();
  color([0.55, 0.60, 0.65]) translate([0, 0, 58.5]) rotate([0, 0, 0]) link_fork();
  color([0.75, 0.30, 0.55]) translate([0, 0, 66.75]) rotate([0, 0, 0]) link_arm();
  color([0.42, 0.52, 0.28]) translate([0, 0, 77.75]) rotate([0, 0, 90]) link_pin();
  color([0.80, 0.24, 0.20]) translate([0, 21.85, 77.75]) rotate([90, 0, 0]) pin_washer();
  color([0.20, 0.45, 0.75]) translate([0, 28.1, 77.75]) rotate([90, 0, 0]) lock_nut();
}

assembly();
