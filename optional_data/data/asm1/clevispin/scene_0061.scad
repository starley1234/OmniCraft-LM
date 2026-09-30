$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 60 mm clevis, pin d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-30, -30, 0]) cube([60, 60, 55]);
    translate([-31, -9, 12]) cube([62, 18, 44]);
    translate([0, 0, 29.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 8.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-45, -8.75, 0]) cube([90, 17.5, 34]);
    translate([0, 0, 17]) rotate([90, 0, 0]) cylinder(h = 19.5, d = 8.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 106, d = 8, center = true);
  translate([-58, 0, 0]) rotate([0, 90, 0]) cylinder(h = 6, d = 14);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 29.25]) rotate([0, 0, 90]) pin();
}

assembly();
