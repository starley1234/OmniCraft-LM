$fn = 32;

// ------------------------------------------------------------------------
// Comb hinge with flap: leaf 52.6 x 24 mm, pin d6, flap 46 mm
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module hinge_bed() {
  difference() {
    translate([-60, -35, 0]) cube([120, 70, 10]);
  }
}

// --- part 2 ---
module hinge_riser() {
  difference() {
    translate([-30.3, -26, 0]) cube([60.6, 52, 6]);
  }
}

// --- part 3 ---
module hinge_leaf_a() {
  difference() {
    union() {
      translate([-23.3, -10, -5]) cube([10, 34, 10]);
      translate([1.1, -10, -5]) cube([10, 34, 10]);
      translate([-26.3, 11.48, -5]) cube([52.6, 12.52, 10]);
    }
    translate([-18.3, 0, 0]) rotate([0, 90, 0]) cylinder(h = 12, d = 6.8, center = true);
    translate([6.1, 0, 0]) rotate([0, 90, 0]) cylinder(h = 12, d = 6.8, center = true);
  }
}

// --- part 4 ---
module hinge_leaf_b() {
  difference() {
    union() {
      translate([-11.1, -24, -5]) cube([10, 34, 10]);
      translate([13.3, -24, -5]) cube([10, 34, 10]);
      translate([-26.3, -24, -5]) cube([52.6, 12.52, 10]);
    }
    translate([-6.1, 0, 0]) rotate([0, 90, 0]) cylinder(h = 12, d = 6.8, center = true);
    translate([18.3, 0, 0]) rotate([0, 90, 0]) cylinder(h = 12, d = 6.8, center = true);
  }
}

// --- part 5 ---
module hinge_flap() {
  difference() {
    translate([-23.3, -23, 0]) cube([46.6, 46, 8]);
  }
}

// --- part 6 ---
module hinge_pin() {
  rotate([0, 90, 0]) cylinder(h = 72.6, d = 6, center = true);
  translate([-39.3, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 10);
}

// --- part 7 ---
module pin_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 14);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 6.8);
    }
}

// --- part 8 ---
module pin_nut() {
  difference() {
    linear_extrude(height = 6) polygon(points = [[6.351, 0], [3.175, 5.5], [-3.175, 5.5], [-6.351, 0], [-3.175, -5.5], [3.175, -5.5]]);
    translate([0, 0, -1]) cylinder(h = 8, d = 6.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) hinge_bed();
  color([0.20, 0.45, 0.75]) translate([0, 0, 10.25]) rotate([0, 0, 0]) hinge_riser();
  color([0.25, 0.62, 0.32]) translate([0, 0, 21.5]) rotate([0, 0, 0]) hinge_leaf_a();
  color([0.92, 0.70, 0.18]) translate([0, 0, 21.5]) rotate([0, 0, 0]) hinge_leaf_b();
  color([0.58, 0.35, 0.70]) translate([0, -24.25, 39.5]) rotate([90, 0, 0]) hinge_flap();
  color([0.16, 0.66, 0.66]) translate([0, 0, 21.5]) rotate([0, 0, 0]) hinge_pin();
  color([0.85, 0.48, 0.18]) translate([36.55, 0, 21.5]) rotate([0, 90, 0]) pin_washer();
  color([0.55, 0.60, 0.65]) translate([38.4, 0, 21.5]) rotate([0, 90, 0]) pin_nut();
}

assembly();
