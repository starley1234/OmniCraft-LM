$fn = 32;

// ------------------------------------------------------------------------
// Motor drive station: motor 70 x 50 mm, shaft d8, pulley d46
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module station_bed() {
  difference() {
    translate([-90, -40, 0]) cube([180, 80, 10]);
  }
}

// --- part 2 ---
module drive_motor() {
  union() {
    translate([-35, -21, 0]) cube([70, 42, 50]);
    translate([39, 0, 25]) rotate([0, 90, 0]) cylinder(h = 8, d = 26, center = true);
  }
}

// --- part 3 ---
module pillow_block() {
  difference() {
    translate([-14, -20, 0]) cube([28, 40, 33.4]);
    translate([0, 0, 25]) rotate([0, 90, 0]) cylinder(h = 30, d = 8.8, center = true);
  }
}

// --- part 4 ---
module drive_shaft() {
  translate([0, 0, -33.75]) cylinder(h = 67.5, d = 8);
}

// --- part 5 ---
module shaft_collar() {
  difference() {
    cylinder(h = 10, d = 20);
    translate([0, 0, -1]) cylinder(h = 12, d = 8.8);
    translate([0, 0, 5]) rotate([90, 0, 0]) cylinder(h = 22, d = 3.5, center = true);
  }
}

// --- part 6 ---
module collar_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 23);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 8.8);
    }
}

// --- part 7 ---
module drive_pulley() {
  difference() {
    union() {
      cylinder(h = 20, d = 16.8);
      cylinder(h = 3, d = 46);
      translate([0, 0, 17]) cylinder(h = 3, d = 46);
    }
    translate([0, 0, -1]) cylinder(h = 22, d = 8.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) station_bed();
  color([0.20, 0.45, 0.75]) translate([-49, 0, 10.25]) rotate([0, 0, 0]) drive_motor();
  color([0.25, 0.62, 0.32]) translate([29.5, 0, 10.25]) rotate([0, 0, 0]) pillow_block();
  color([0.92, 0.70, 0.18]) translate([28, 0, 35.25]) rotate([0, 90, 0]) drive_shaft();
  color([0.58, 0.35, 0.70]) translate([-0.75, 0, 35.25]) rotate([0, 90, 0]) shaft_collar();
  color([0.16, 0.66, 0.66]) translate([-2.6, 0, 35.25]) rotate([0, 90, 0]) collar_washer();
  color([0.85, 0.48, 0.18]) translate([43.75, 0, 35.25]) rotate([0, 90, 0]) drive_pulley();
}

assembly();
