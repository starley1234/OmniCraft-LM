$fn = 32;

// ------------------------------------------------------------------------
// C clamp: throat 40 mm, screw d10
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module clamp_arm() {
  difference() {
    translate([-35, -17, 0]) cube([70, 34, 8]);
    translate([25, 0, -1]) cylinder(h = 10, d = 10.8);
  }
}

// --- part 2 ---
module clamp_spine() {
  difference() {
    translate([-28, -17, 0]) cube([56, 34, 10]);
  }
}

// --- part 3 ---
module clamp_screw() {
  translate([0, 0, -30.875]) cylinder(h = 61.75, d = 10);
}

// --- part 4 ---
module clamp_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 18);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 10.8);
    }
}

// --- part 5 ---
module clamp_nut() {
  difference() {
    linear_extrude(height = 7) polygon(points = [[8.66, 0], [4.33, 7.5], [-4.33, 7.5], [-8.66, 0], [-4.33, -7.5], [4.33, -7.5]]);
    translate([0, 0, -1]) cylinder(h = 9, d = 10.8);
  }
}

// --- part 6 ---
module tommy_bar() {
  translate([0, 0, -20]) cylinder(h = 40, d = 6);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) clamp_arm();
  color([0.20, 0.45, 0.75]) translate([0, 0, 40]) rotate([0, 0, 0]) clamp_arm();
  color([0.25, 0.62, 0.32]) translate([-45.25, 0, 24]) rotate([0, 90, 0]) clamp_spine();
  color([0.92, 0.70, 0.18]) translate([25, 0, 23.375]) rotate([0, 0, 0]) clamp_screw();
  color([0.58, 0.35, 0.70]) translate([25, 0, -1.85]) rotate([0, 0, 0]) clamp_washer();
  color([0.16, 0.66, 0.66]) translate([25, 0, -9.1]) rotate([0, 0, 0]) clamp_nut();
  color([0.85, 0.48, 0.18]) translate([25, 0, 57.5]) rotate([0, 90, 0]) tommy_bar();
}

assembly();
