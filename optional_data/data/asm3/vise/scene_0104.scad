$fn = 32;

// ------------------------------------------------------------------------
// Machine vise: screw d8, jaws 28 x 38 mm
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module vise_bed() {
  difference() {
    translate([-60, -40, 0]) cube([120, 80, 10]);
  }
}

// --- part 2 ---
module vise_jaw() {
  difference() {
    translate([-14, -22, 0]) cube([28, 44, 38]);
    translate([0, 0, 19]) rotate([0, 90, 0]) cylinder(h = 30, d = 8.8, center = true);
  }
}

// --- part 3 ---
module vise_screw() {
  translate([0, 0, -45]) cylinder(h = 90, d = 8);
}

// --- part 4 ---
module screw_collar() {
  difference() {
    cylinder(h = 8, d = 18);
    translate([0, 0, -1]) cylinder(h = 10, d = 8.8);
    translate([0, 0, 4]) rotate([90, 0, 0]) cylinder(h = 20, d = 3.5, center = true);
  }
}

// --- part 5 ---
module screw_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 20);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 8.8);
    }
}

// --- part 6 ---
module vise_handle() {
  cylinder(h = 26, d = 10);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) vise_bed();
  color([0.20, 0.45, 0.75]) translate([25, 0, 10.25]) rotate([0, 0, 0]) vise_jaw();
  color([0.25, 0.62, 0.32]) translate([-25, 0, 10.25]) rotate([0, 0, 0]) vise_jaw();
  color([0.92, 0.70, 0.18]) translate([-10, 0, 29.25]) rotate([0, 90, 0]) vise_screw();
  color([0.58, 0.35, 0.70]) translate([-50, 0, 29.25]) rotate([0, 90, 0]) screw_collar();
  color([0.16, 0.66, 0.66]) translate([-51.85, 0, 29.25]) rotate([0, 90, 0]) screw_washer();
  color([0.85, 0.48, 0.18]) translate([-60.25, 0, 42.25]) rotate([90, 0, 0]) vise_handle();
}

assembly();
