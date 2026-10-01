$fn = 32;

// ------------------------------------------------------------------------
// Motor drive station: motor 50 x 42 mm, shaft d10, pulley d40
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module station_bed() {
  difference() {
    translate([-90, -35, 0]) cube([180, 70, 10]);
  }
}

// --- part 2 ---
module drive_motor() {
  union() {
    translate([-25, -21, 0]) cube([50, 42, 42]);
    translate([28, 0, 21]) rotate([0, 90, 0]) cylinder(h = 6, d = 26, center = true);
  }
}

// --- part 3 ---
module pillow_block() {
  difference() {
    translate([-14, -18, 0]) cube([28, 36, 30.4]);
    translate([0, 0, 21]) rotate([0, 90, 0]) cylinder(h = 30, d = 10.8, center = true);
  }
}

// --- part 4 ---
module drive_shaft() {
  translate([0, 0, -31.75]) cylinder(h = 63.5, d = 10);
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
      cylinder(h = 18, d = 18.8);
      cylinder(h = 4, d = 40);
      translate([0, 0, 14]) cylinder(h = 4, d = 40);
    }
    translate([0, 0, -1]) cylinder(h = 20, d = 10.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) station_bed();
  color([0.20, 0.45, 0.75]) translate([-59, 0, 10.25]) rotate([0, 0, 0]) drive_motor();
  color([0.25, 0.62, 0.32]) translate([5.5, 0, 10.25]) rotate([0, 0, 0]) pillow_block();
  color([0.92, 0.70, 0.18]) translate([4, 0, 31.25]) rotate([0, 90, 0]) drive_shaft();
  color([0.58, 0.35, 0.70]) translate([-22.75, 0, 31.25]) rotate([0, 90, 0]) shaft_collar();
  color([0.16, 0.66, 0.66]) translate([-24.6, 0, 31.25]) rotate([0, 90, 0]) collar_washer();
  color([0.85, 0.48, 0.18]) translate([19.75, 0, 31.25]) rotate([0, 90, 0]) drive_pulley();
}

assembly();
