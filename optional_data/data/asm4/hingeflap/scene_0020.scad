$fn = 32;

// ------------------------------------------------------------------------
// Comb hinge with flap: leaf 89 x 22 mm, pin d5, flap 40 mm
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module hinge_bed() {
  difference() {
    translate([-65, -40, 0]) cube([130, 80, 12]);
  }
}

// --- part 2 ---
module hinge_riser() {
  difference() {
    translate([-48.5, -24, 0]) cube([97, 48, 8]);
  }
}

// --- part 3 ---
module hinge_leaf_a() {
  difference() {
    union() {
      translate([-41.5, -8, -5]) cube([12, 30, 10]);
      translate([-13.1, -8, -5]) cube([12, 30, 10]);
      translate([15.3, -8, -5]) cube([12, 30, 10]);
      translate([-44.5, 9.734, -5]) cube([89, 12.266, 10]);
    }
    translate([-35.5, 0, 0]) rotate([0, 90, 0]) cylinder(h = 14, d = 5.8, center = true);
    translate([-7.1, 0, 0]) rotate([0, 90, 0]) cylinder(h = 14, d = 5.8, center = true);
    translate([21.3, 0, 0]) rotate([0, 90, 0]) cylinder(h = 14, d = 5.8, center = true);
  }
}

// --- part 4 ---
module hinge_leaf_b() {
  difference() {
    union() {
      translate([-27.3, -22, -5]) cube([12, 30, 10]);
      translate([1.1, -22, -5]) cube([12, 30, 10]);
      translate([29.5, -22, -5]) cube([12, 30, 10]);
      translate([-44.5, -22, -5]) cube([89, 12.266, 10]);
    }
    translate([-21.3, 0, 0]) rotate([0, 90, 0]) cylinder(h = 14, d = 5.8, center = true);
    translate([7.1, 0, 0]) rotate([0, 90, 0]) cylinder(h = 14, d = 5.8, center = true);
    translate([35.5, 0, 0]) rotate([0, 90, 0]) cylinder(h = 14, d = 5.8, center = true);
  }
}

// --- part 5 ---
module hinge_flap() {
  difference() {
    translate([-41.5, -20, 0]) cube([83, 40, 8]);
  }
}

// --- part 6 ---
module hinge_pin() {
  rotate([0, 90, 0]) cylinder(h = 109, d = 5, center = true);
  translate([-57.5, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 9);
}

// --- part 7 ---
module pin_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 13);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 5.8);
    }
}

// --- part 8 ---
module pin_nut() {
  difference() {
    linear_extrude(height = 6) polygon(points = [[5.774, 0], [2.887, 5], [-2.887, 5], [-5.774, 0], [-2.887, -5], [2.887, -5]]);
    translate([0, 0, -1]) cylinder(h = 8, d = 5.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) hinge_bed();
  color([0.20, 0.45, 0.75]) translate([0, 0, 12.25]) rotate([0, 0, 0]) hinge_riser();
  color([0.25, 0.62, 0.32]) translate([0, 0, 25.5]) rotate([0, 0, 0]) hinge_leaf_a();
  color([0.92, 0.70, 0.18]) translate([0, 0, 25.5]) rotate([0, 0, 0]) hinge_leaf_b();
  color([0.58, 0.35, 0.70]) translate([0, -22.25, 40.5]) rotate([90, 0, 0]) hinge_flap();
  color([0.16, 0.66, 0.66]) translate([0, 0, 25.5]) rotate([0, 0, 0]) hinge_pin();
  color([0.85, 0.48, 0.18]) translate([54.75, 0, 25.5]) rotate([0, 90, 0]) pin_washer();
  color([0.55, 0.60, 0.65]) translate([56.6, 0, 25.5]) rotate([0, 90, 0]) pin_nut();
}

assembly();
