$fn = 32;

// ------------------------------------------------------------------------
// Trolley wheel set: wheels d60, fork 80 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module trolley_fork() {
  difference() {
    union() {
      translate([-38, 13.375, 0]) cube([76, 14.8, 80]);
      translate([-38, -28.175, 0]) cube([76, 14.8, 80]);
      translate([-38, -28.175, 80]) cube([76, 56.35, 8]);
    }
    translate([0, -20.775, 38]) rotate([90, 0, 0]) cylinder(h = 16.8, d = 10.8, center = true);
    translate([0, 20.775, 38]) rotate([90, 0, 0]) cylinder(h = 16.8, d = 10.8, center = true);
  }
}

// --- part 2 ---
module trolley_wheel() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 60);
      translate([0, 0, -1]) cylinder(h = 14, d = 10.8);
    }
}

// --- part 3 ---
module trolley_axle() {
  translate([0, 0, -27.175]) cylinder(h = 54.35, d = 10);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) trolley_fork();
  color([0.20, 0.45, 0.75]) translate([0, -1.125, 38]) rotate([90, 0, 0]) trolley_wheel();
  color([0.25, 0.62, 0.32]) translate([0, 13.125, 38]) rotate([90, 0, 0]) trolley_wheel();
  color([0.92, 0.70, 0.18]) translate([0, 0, 38]) rotate([90, 0, 0]) trolley_axle();
}

assembly();
