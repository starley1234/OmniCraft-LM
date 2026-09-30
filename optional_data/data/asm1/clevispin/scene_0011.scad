$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 60 mm clevis, pin d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-30, -25, 0]) cube([60, 50, 55]);
    translate([-31, -9, 10]) cube([62, 18, 46]);
    translate([0, 0, 27.25]) rotate([90, 0, 0]) cylinder(h = 52, d = 8.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-40, -8.75, 0]) cube([80, 17.5, 34]);
    translate([0, 0, 17]) rotate([90, 0, 0]) cylinder(h = 19.5, d = 8.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 96, d = 8, center = true);
  translate([-54, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 14);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 10.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 27.25]) rotate([0, 0, 90]) pin();
}

assembly();
