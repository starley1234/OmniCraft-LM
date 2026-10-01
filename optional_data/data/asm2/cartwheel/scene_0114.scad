$fn = 32;

// ------------------------------------------------------------------------
// Trolley wheel set: wheels d40, fork 56 mm tall
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module trolley_fork() {
  difference() {
    union() {
      translate([-28, 11.375, 0]) cube([56, 16.8, 56]);
      translate([-28, -28.175, 0]) cube([56, 16.8, 56]);
      translate([-28, -28.175, 56]) cube([56, 56.35, 10]);
    }
    translate([0, -19.775, 28]) rotate([90, 0, 0]) cylinder(h = 18.8, d = 12.8, center = true);
    translate([0, 19.775, 28]) rotate([90, 0, 0]) cylinder(h = 18.8, d = 12.8, center = true);
  }
}

// --- part 2 ---
module trolley_wheel() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 40);
      translate([0, 0, -1]) cylinder(h = 12, d = 12.8);
    }
}

// --- part 3 ---
module trolley_axle() {
  translate([0, 0, -27.175]) cylinder(h = 54.35, d = 12);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) trolley_fork();
  color([0.20, 0.45, 0.75]) translate([0, -1.125, 28]) rotate([90, 0, 0]) trolley_wheel();
  color([0.25, 0.62, 0.32]) translate([0, 11.125, 28]) rotate([90, 0, 0]) trolley_wheel();
  color([0.92, 0.70, 0.18]) translate([0, 0, 28]) rotate([90, 0, 0]) trolley_axle();
}

assembly();
