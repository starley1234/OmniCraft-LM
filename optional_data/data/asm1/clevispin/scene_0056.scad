$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 50 mm clevis, pin d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-25, -30, 0]) cube([50, 60, 55]);
    translate([-26, -9, 12]) cube([52, 18, 44]);
    translate([0, 0, 32.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 8.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-45, -8.75, 0]) cube([90, 17.5, 40]);
    translate([0, 0, 20]) rotate([90, 0, 0]) cylinder(h = 19.5, d = 8.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 106, d = 8, center = true);
  translate([-59, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 14);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 32.25]) rotate([0, 0, 90]) pin();
}

assembly();
