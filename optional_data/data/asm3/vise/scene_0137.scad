$fn = 32;

// ------------------------------------------------------------------------
// Machine vise: screw d12, jaws 24 x 30 mm
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module vise_bed() {
  difference() {
    translate([-55, -35, 0]) cube([110, 70, 8]);
  }
}

// --- part 2 ---
module vise_jaw() {
  difference() {
    translate([-12, -20, 0]) cube([24, 40, 30]);
    translate([0, 0, 15]) rotate([0, 90, 0]) cylinder(h = 26, d = 12.8, center = true);
  }
}

// --- part 3 ---
module vise_screw() {
  translate([0, 0, -46]) cylinder(h = 92, d = 12);
}

// --- part 4 ---
module screw_collar() {
  difference() {
    cylinder(h = 10, d = 22);
    translate([0, 0, -1]) cylinder(h = 12, d = 12.8);
    translate([0, 0, 5]) rotate([90, 0, 0]) cylinder(h = 24, d = 3.5, center = true);
  }
}

// --- part 5 ---
module screw_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 24);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 12.8);
    }
}

// --- part 6 ---
module vise_handle() {
  cylinder(h = 34, d = 8);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) vise_bed();
  color([0.20, 0.45, 0.75]) translate([28, 0, 8.25]) rotate([0, 0, 0]) vise_jaw();
  color([0.25, 0.62, 0.32]) translate([-28, 0, 8.25]) rotate([0, 0, 0]) vise_jaw();
  color([0.92, 0.70, 0.18]) translate([-10, 0, 23.25]) rotate([0, 90, 0]) vise_screw();
  color([0.58, 0.35, 0.70]) translate([-51, 0, 23.25]) rotate([0, 90, 0]) screw_collar();
  color([0.16, 0.66, 0.66]) translate([-52.85, 0, 23.25]) rotate([0, 90, 0]) screw_washer();
  color([0.85, 0.48, 0.18]) translate([-60.25, 0, 40.25]) rotate([90, 0, 0]) vise_handle();
}

assembly();
