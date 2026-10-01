$fn = 32;

// ------------------------------------------------------------------------
// Butt hinge: hinge 60 mm, leaf swung 270 deg
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module hinge_base() {
  difference() {
    union() {
      translate([-30, -12, -5]) cube([14.55, 62, 10]);
      translate([-7.275, -12, -5]) cube([14.55, 62, 10]);
      translate([15.45, -12, -5]) cube([14.55, 62, 10]);
      translate([-30, 13.3, -5]) cube([60, 36.7, 10]);
    }
    translate([-22.725, 0, 0]) rotate([0, 90, 0]) cylinder(h = 16.55, d = 6.8, center = true);
    translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(h = 16.55, d = 6.8, center = true);
    translate([22.725, 0, 0]) rotate([0, 90, 0]) cylinder(h = 16.55, d = 6.8, center = true);
  }
}

// --- part 2 ---
module hinge_mover() {
  difference() {
    union() {
      translate([-15.15, -50, -5]) cube([7.575, 62, 10]);
      translate([7.575, -50, -5]) cube([7.575, 62, 10]);
      translate([-30, -50, -5]) cube([60, 36.7, 10]);
    }
    translate([-11.362, 0, 0]) rotate([0, 90, 0]) cylinder(h = 9.575, d = 6.8, center = true);
    translate([11.362, 0, 0]) rotate([0, 90, 0]) cylinder(h = 9.575, d = 6.8, center = true);
  }
}

// --- part 3 ---
module hinge_pin() {
  rotate([0, 90, 0]) cylinder(h = 62.5, d = 6, center = true);
  translate([-34.25, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 10);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 12]) rotate([0, 0, 0]) hinge_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 12]) rotate([270, 0, 0]) hinge_mover();
  color([0.25, 0.62, 0.32]) translate([0, 0, 12]) rotate([0, 0, 0]) hinge_pin();
}

assembly();
