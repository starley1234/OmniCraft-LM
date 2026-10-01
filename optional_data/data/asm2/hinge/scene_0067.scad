$fn = 32;

// ------------------------------------------------------------------------
// Butt hinge: hinge 100 mm, leaf swung 45 deg
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module hinge_base() {
  difference() {
    union() {
      translate([-50, -10, -4]) cube([24.55, 40, 8]);
      translate([-12.275, -10, -4]) cube([24.55, 40, 8]);
      translate([25.45, -10, -4]) cube([24.55, 40, 8]);
      translate([-50, 11.07, -4]) cube([100, 18.93, 8]);
    }
    translate([-37.725, 0, 0]) rotate([0, 90, 0]) cylinder(h = 26.55, d = 4.8, center = true);
    translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(h = 26.55, d = 4.8, center = true);
    translate([37.725, 0, 0]) rotate([0, 90, 0]) cylinder(h = 26.55, d = 4.8, center = true);
  }
}

// --- part 2 ---
module hinge_mover() {
  difference() {
    union() {
      translate([-25.15, -50, -4]) cube([12.575, 60, 8]);
      translate([12.575, -50, -4]) cube([12.575, 60, 8]);
      translate([-50, -50, -4]) cube([100, 38.93, 8]);
    }
    translate([-18.863, 0, 0]) rotate([0, 90, 0]) cylinder(h = 14.575, d = 4.8, center = true);
    translate([18.863, 0, 0]) rotate([0, 90, 0]) cylinder(h = 14.575, d = 4.8, center = true);
  }
}

// --- part 3 ---
module hinge_pin() {
  rotate([0, 90, 0]) cylinder(h = 102.5, d = 4, center = true);
  translate([-54.25, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 8);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 10]) rotate([0, 0, 0]) hinge_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 10]) rotate([45, 0, 0]) hinge_mover();
  color([0.25, 0.62, 0.32]) translate([0, 0, 10]) rotate([0, 0, 0]) hinge_pin();
}

assembly();
