$fn = 32;

// ------------------------------------------------------------------------
// Butt hinge: hinge 80 mm, leaf swung 270 deg
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module hinge_base() {
  difference() {
    union() {
      translate([-40, -12, -5]) cube([19.55, 52, 10]);
      translate([-9.775, -12, -5]) cube([19.55, 52, 10]);
      translate([20.45, -12, -5]) cube([19.55, 52, 10]);
      translate([-40, 13.3, -5]) cube([80, 26.7, 10]);
    }
    translate([-30.225, 0, 0]) rotate([0, 90, 0]) cylinder(h = 21.55, d = 6.8, center = true);
    translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(h = 21.55, d = 6.8, center = true);
    translate([30.225, 0, 0]) rotate([0, 90, 0]) cylinder(h = 21.55, d = 6.8, center = true);
  }
}

// --- part 2 ---
module hinge_mover() {
  difference() {
    union() {
      translate([-20.15, -40, -5]) cube([10.075, 52, 10]);
      translate([10.075, -40, -5]) cube([10.075, 52, 10]);
      translate([-40, -40, -5]) cube([80, 26.7, 10]);
    }
    translate([-15.113, 0, 0]) rotate([0, 90, 0]) cylinder(h = 12.075, d = 6.8, center = true);
    translate([15.113, 0, 0]) rotate([0, 90, 0]) cylinder(h = 12.075, d = 6.8, center = true);
  }
}

// --- part 3 ---
module hinge_pin() {
  rotate([0, 90, 0]) cylinder(h = 82.5, d = 6, center = true);
  translate([-44.25, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 10);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 12]) rotate([0, 0, 0]) hinge_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 12]) rotate([270, 0, 0]) hinge_mover();
  color([0.25, 0.62, 0.32]) translate([0, 0, 12]) rotate([0, 0, 0]) hinge_pin();
}

assembly();
