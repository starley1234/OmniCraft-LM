$fn = 32;

// ------------------------------------------------------------------------
// Butt hinge: hinge 80 mm, leaf swung 45 deg
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module hinge_base() {
  difference() {
    union() {
      translate([-40, -12, -4.5]) cube([19.55, 62, 9]);
      translate([-9.775, -12, -4.5]) cube([19.55, 62, 9]);
      translate([20.45, -12, -4.5]) cube([19.55, 62, 9]);
      translate([-40, 13.116, -4.5]) cube([80, 36.884, 9]);
    }
    translate([-30.225, 0, 0]) rotate([0, 90, 0]) cylinder(h = 21.55, d = 5.8, center = true);
    translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(h = 21.55, d = 5.8, center = true);
    translate([30.225, 0, 0]) rotate([0, 90, 0]) cylinder(h = 21.55, d = 5.8, center = true);
  }
}

// --- part 2 ---
module hinge_mover() {
  difference() {
    union() {
      translate([-20.15, -40, -4.5]) cube([10.075, 52, 9]);
      translate([10.075, -40, -4.5]) cube([10.075, 52, 9]);
      translate([-40, -40, -4.5]) cube([80, 26.884, 9]);
    }
    translate([-15.113, 0, 0]) rotate([0, 90, 0]) cylinder(h = 12.075, d = 5.8, center = true);
    translate([15.113, 0, 0]) rotate([0, 90, 0]) cylinder(h = 12.075, d = 5.8, center = true);
  }
}

// --- part 3 ---
module hinge_pin() {
  rotate([0, 90, 0]) cylinder(h = 82.5, d = 5, center = true);
  translate([-44.25, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 9);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 12]) rotate([0, 0, 0]) hinge_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 12]) rotate([45, 0, 0]) hinge_mover();
  color([0.25, 0.62, 0.32]) translate([0, 0, 12]) rotate([0, 0, 0]) hinge_pin();
}

assembly();
