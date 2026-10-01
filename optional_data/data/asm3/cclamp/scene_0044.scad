$fn = 32;

// ------------------------------------------------------------------------
// C clamp: throat 45 mm, screw d8
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module clamp_arm() {
  difference() {
    translate([-30, -17, 0]) cube([60, 34, 8]);
    translate([20, 0, -1]) cylinder(h = 10, d = 8.8);
  }
}

// --- part 2 ---
module clamp_spine() {
  difference() {
    translate([-30.5, -17, 0]) cube([61, 34, 12]);
  }
}

// --- part 3 ---
module clamp_screw() {
  translate([0, 0, -33.375]) cylinder(h = 66.75, d = 8);
}

// --- part 4 ---
module clamp_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 16);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 8.8);
    }
}

// --- part 5 ---
module clamp_nut() {
  difference() {
    linear_extrude(height = 7) polygon(points = [[7.506, 0], [3.753, 6.5], [-3.753, 6.5], [-7.506, 0], [-3.753, -6.5], [3.753, -6.5]]);
    translate([0, 0, -1]) cylinder(h = 9, d = 8.8);
  }
}

// --- part 6 ---
module tommy_bar() {
  translate([0, 0, -20]) cylinder(h = 40, d = 8);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) clamp_arm();
  color([0.20, 0.45, 0.75]) translate([0, 0, 45]) rotate([0, 0, 0]) clamp_arm();
  color([0.25, 0.62, 0.32]) translate([-42.25, 0, 26.5]) rotate([0, 90, 0]) clamp_spine();
  color([0.92, 0.70, 0.18]) translate([20, 0, 25.875]) rotate([0, 0, 0]) clamp_screw();
  color([0.58, 0.35, 0.70]) translate([20, 0, -1.85]) rotate([0, 0, 0]) clamp_washer();
  color([0.16, 0.66, 0.66]) translate([20, 0, -9.1]) rotate([0, 0, 0]) clamp_nut();
  color([0.85, 0.48, 0.18]) translate([20, 0, 63.5]) rotate([0, 90, 0]) tommy_bar();
}

assembly();
