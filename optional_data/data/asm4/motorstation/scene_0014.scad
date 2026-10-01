$fn = 32;

// ------------------------------------------------------------------------
// Motor drive station: motor 50 x 42 mm, shaft d10, pulley d40
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module station_bed() {
  difference() {
    translate([-75, -35, 0]) cube([150, 70, 12]);
  }
}

// --- part 2 ---
module drive_motor() {
  union() {
    translate([-25, -21, 0]) cube([50, 42, 42]);
    translate([29, 0, 21]) rotate([0, 90, 0]) cylinder(h = 8, d = 26, center = true);
  }
}

// --- part 3 ---
module pillow_block() {
  difference() {
    translate([-16, -18, 0]) cube([32, 36, 30.4]);
    translate([0, 0, 21]) rotate([0, 90, 0]) cylinder(h = 34, d = 10.8, center = true);
  }
}

// --- part 4 ---
module drive_shaft() {
  translate([0, 0, -34.75]) cylinder(h = 69.5, d = 10);
}

// --- part 5 ---
module shaft_collar() {
  difference() {
    cylinder(h = 8, d = 22);
    translate([0, 0, -1]) cylinder(h = 10, d = 10.8);
    translate([0, 0, 4]) rotate([90, 0, 0]) cylinder(h = 24, d = 3.5, center = true);
  }
}

// --- part 6 ---
module collar_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 25);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 10.8);
    }
}

// --- part 7 ---
module drive_pulley() {
  difference() {
    union() {
      cylinder(h = 20, d = 18.8);
      cylinder(h = 3, d = 40);
      translate([0, 0, 17]) cylinder(h = 3, d = 40);
    }
    translate([0, 0, -1]) cylinder(h = 22, d = 10.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) station_bed();
  color([0.20, 0.45, 0.75]) translate([-44, 0, 12.25]) rotate([0, 0, 0]) drive_motor();
  color([0.25, 0.62, 0.32]) translate([24.5, 0, 12.25]) rotate([0, 0, 0]) pillow_block();
  color([0.92, 0.70, 0.18]) translate([24, 0, 33.25]) rotate([0, 90, 0]) drive_shaft();
  color([0.58, 0.35, 0.70]) translate([-5.75, 0, 33.25]) rotate([0, 90, 0]) shaft_collar();
  color([0.16, 0.66, 0.66]) translate([-7.6, 0, 33.25]) rotate([0, 90, 0]) collar_washer();
  color([0.85, 0.48, 0.18]) translate([40.75, 0, 33.25]) rotate([0, 90, 0]) drive_pulley();
}

assembly();
