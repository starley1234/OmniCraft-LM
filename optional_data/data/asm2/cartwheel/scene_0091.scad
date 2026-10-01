$fn = 32;

// ------------------------------------------------------------------------
// Trolley wheel set: wheels d40, fork 88 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module trolley_fork() {
  difference() {
    union() {
      translate([-28, 10.875, 0]) cube([56, 14.8, 88]);
      translate([-28, -25.675, 0]) cube([56, 14.8, 88]);
      translate([-28, -25.675, 88]) cube([56, 51.35, 8]);
    }
    translate([0, -18.275, 36]) rotate([90, 0, 0]) cylinder(h = 16.8, d = 10.8, center = true);
    translate([0, 18.275, 36]) rotate([90, 0, 0]) cylinder(h = 16.8, d = 10.8, center = true);
  }
}

// --- part 2 ---
module trolley_wheel() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 40);
      translate([0, 0, -1]) cylinder(h = 12, d = 10.8);
    }
}

// --- part 3 ---
module trolley_axle() {
  translate([0, 0, -24.675]) cylinder(h = 49.35, d = 10);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) trolley_fork();
  color([0.20, 0.45, 0.75]) translate([0, -0.625, 36]) rotate([90, 0, 0]) trolley_wheel();
  color([0.25, 0.62, 0.32]) translate([0, 10.625, 36]) rotate([90, 0, 0]) trolley_wheel();
  color([0.92, 0.70, 0.18]) translate([0, 0, 36]) rotate([90, 0, 0]) trolley_axle();
}

assembly();
