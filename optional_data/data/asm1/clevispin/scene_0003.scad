$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 60 mm clevis, pin d12
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-30, -30, 0]) cube([60, 60, 75]);
    translate([-31, -7, 10]) cube([62, 14, 66]);
    translate([0, 0, 24.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 12.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-40, -6.75, 0]) cube([80, 13.5, 28]);
    translate([0, 0, 14]) rotate([90, 0, 0]) cylinder(h = 15.5, d = 12.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 96, d = 12, center = true);
  translate([-54, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 18);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 10.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 24.25]) rotate([0, 0, 90]) pin();
}

assembly();
