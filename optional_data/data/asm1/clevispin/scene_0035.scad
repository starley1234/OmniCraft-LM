$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 70 mm clevis, pin d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-35, -30, 0]) cube([70, 60, 75]);
    translate([-36, -7, 10]) cube([72, 14, 66]);
    translate([0, 0, 24.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 8.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-45, -6.75, 0]) cube([90, 13.5, 28]);
    translate([0, 0, 14]) rotate([90, 0, 0]) cylinder(h = 15.5, d = 8.8, center = true);
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
  translate([0, 0, 10.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 24.25]) rotate([0, 0, 90]) pin();
}

assembly();
