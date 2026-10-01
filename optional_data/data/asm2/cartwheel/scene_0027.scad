$fn = 32;

// ------------------------------------------------------------------------
// Trolley wheel set: wheels d60, fork 84 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module trolley_fork() {
  difference() {
    union() {
      translate([-35, 10.875, 0]) cube([70, 14.8, 84]);
      translate([-35, -25.675, 0]) cube([70, 14.8, 84]);
      translate([-35, -25.675, 84]) cube([70, 51.35, 10]);
    }
    translate([0, -18.275, 42]) rotate([90, 0, 0]) cylinder(h = 16.8, d = 10.8, center = true);
    translate([0, 18.275, 42]) rotate([90, 0, 0]) cylinder(h = 16.8, d = 10.8, center = true);
  }
}

// --- part 2 ---
module trolley_wheel() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 60);
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
  color([0.20, 0.45, 0.75]) translate([0, -0.625, 42]) rotate([90, 0, 0]) trolley_wheel();
  color([0.25, 0.62, 0.32]) translate([0, 10.625, 42]) rotate([90, 0, 0]) trolley_wheel();
  color([0.92, 0.70, 0.18]) translate([0, 0, 42]) rotate([90, 0, 0]) trolley_axle();
}

assembly();
