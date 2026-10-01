$fn = 32;

// ------------------------------------------------------------------------
// Trolley wheel set: wheels d50, fork 66 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module trolley_fork() {
  difference() {
    union() {
      translate([-30, 12.875, 0]) cube([60, 16.8, 66]);
      translate([-30, -29.675, 0]) cube([60, 16.8, 66]);
      translate([-30, -29.675, 66]) cube([60, 59.35, 8]);
    }
    translate([0, -21.275, 33]) rotate([90, 0, 0]) cylinder(h = 18.8, d = 12.8, center = true);
    translate([0, 21.275, 33]) rotate([90, 0, 0]) cylinder(h = 18.8, d = 12.8, center = true);
  }
}

// --- part 2 ---
module trolley_wheel() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 50);
      translate([0, 0, -1]) cylinder(h = 14, d = 12.8);
    }
}

// --- part 3 ---
module trolley_axle() {
  translate([0, 0, -28.675]) cylinder(h = 57.35, d = 12);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) trolley_fork();
  color([0.20, 0.45, 0.75]) translate([0, -0.625, 33]) rotate([90, 0, 0]) trolley_wheel();
  color([0.25, 0.62, 0.32]) translate([0, 12.625, 33]) rotate([90, 0, 0]) trolley_wheel();
  color([0.92, 0.70, 0.18]) translate([0, 0, 33]) rotate([90, 0, 0]) trolley_axle();
}

assembly();
