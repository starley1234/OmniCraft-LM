$fn = 32;

// ------------------------------------------------------------------------
// Trolley wheel set: wheels d60, fork 76 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module trolley_fork() {
  difference() {
    union() {
      translate([-35, 11.375, 0]) cube([70, 12.8, 76]);
      translate([-35, -24.175, 0]) cube([70, 12.8, 76]);
      translate([-35, -24.175, 76]) cube([70, 48.35, 8]);
    }
    translate([0, -17.775, 38]) rotate([90, 0, 0]) cylinder(h = 14.8, d = 8.8, center = true);
    translate([0, 17.775, 38]) rotate([90, 0, 0]) cylinder(h = 14.8, d = 8.8, center = true);
  }
}

// --- part 2 ---
module trolley_wheel() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 60);
      translate([0, 0, -1]) cylinder(h = 12, d = 8.8);
    }
}

// --- part 3 ---
module trolley_axle() {
  translate([0, 0, -23.175]) cylinder(h = 46.35, d = 8);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) trolley_fork();
  color([0.20, 0.45, 0.75]) translate([0, -1.125, 38]) rotate([90, 0, 0]) trolley_wheel();
  color([0.25, 0.62, 0.32]) translate([0, 11.125, 38]) rotate([90, 0, 0]) trolley_wheel();
  color([0.92, 0.70, 0.18]) translate([0, 0, 38]) rotate([90, 0, 0]) trolley_axle();
}

assembly();
