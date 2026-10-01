$fn = 32;

// ------------------------------------------------------------------------
// Butt hinge: hinge 100 mm, leaf swung 0 deg
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module hinge_base() {
  difference() {
    union() {
      translate([-50, -12, -5]) cube([24.55, 52, 10]);
      translate([-12.275, -12, -5]) cube([24.55, 52, 10]);
      translate([25.45, -12, -5]) cube([24.55, 52, 10]);
      translate([-50, 13.3, -5]) cube([100, 26.7, 10]);
    }
    translate([-37.725, 0, 0]) rotate([0, 90, 0]) cylinder(h = 26.55, d = 6.8, center = true);
    translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(h = 26.55, d = 6.8, center = true);
    translate([37.725, 0, 0]) rotate([0, 90, 0]) cylinder(h = 26.55, d = 6.8, center = true);
  }
}

// --- part 2 ---
module hinge_mover() {
  difference() {
    union() {
      translate([-25.15, -50, -5]) cube([12.575, 62, 10]);
      translate([12.575, -50, -5]) cube([12.575, 62, 10]);
      translate([-50, -50, -5]) cube([100, 36.7, 10]);
    }
    translate([-18.863, 0, 0]) rotate([0, 90, 0]) cylinder(h = 14.575, d = 6.8, center = true);
    translate([18.863, 0, 0]) rotate([0, 90, 0]) cylinder(h = 14.575, d = 6.8, center = true);
  }
}

// --- part 3 ---
module hinge_pin() {
  rotate([0, 90, 0]) cylinder(h = 102.5, d = 6, center = true);
  translate([-54.25, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 10);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 12]) rotate([0, 0, 0]) hinge_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 12]) rotate([0, 0, 0]) hinge_mover();
  color([0.25, 0.62, 0.32]) translate([0, 0, 12]) rotate([0, 0, 0]) hinge_pin();
}

assembly();
