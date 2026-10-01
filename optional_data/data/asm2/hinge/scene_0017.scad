$fn = 32;

// ------------------------------------------------------------------------
// Butt hinge: hinge 80 mm, leaf swung 45 deg
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module hinge_base() {
  difference() {
    union() {
      translate([-40, -14, -4]) cube([19.55, 54, 8]);
      translate([-9.775, -14, -4]) cube([19.55, 54, 8]);
      translate([20.45, -14, -4]) cube([19.55, 54, 8]);
      translate([-40, 14.86, -4]) cube([80, 25.14, 8]);
    }
    translate([-30.225, 0, 0]) rotate([0, 90, 0]) cylinder(h = 21.55, d = 4.8, center = true);
    translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(h = 21.55, d = 4.8, center = true);
    translate([30.225, 0, 0]) rotate([0, 90, 0]) cylinder(h = 21.55, d = 4.8, center = true);
  }
}

// --- part 2 ---
module hinge_mover() {
  difference() {
    union() {
      translate([-20.15, -50, -4]) cube([10.075, 64, 8]);
      translate([10.075, -50, -4]) cube([10.075, 64, 8]);
      translate([-40, -50, -4]) cube([80, 35.14, 8]);
    }
    translate([-15.113, 0, 0]) rotate([0, 90, 0]) cylinder(h = 12.075, d = 4.8, center = true);
    translate([15.113, 0, 0]) rotate([0, 90, 0]) cylinder(h = 12.075, d = 4.8, center = true);
  }
}

// --- part 3 ---
module hinge_pin() {
  rotate([0, 90, 0]) cylinder(h = 82.5, d = 4, center = true);
  translate([-44.25, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 8);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 14]) rotate([0, 0, 0]) hinge_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 14]) rotate([45, 0, 0]) hinge_mover();
  color([0.25, 0.62, 0.32]) translate([0, 0, 14]) rotate([0, 0, 0]) hinge_pin();
}

assembly();
