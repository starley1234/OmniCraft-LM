$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 50 mm clevis, pin d12
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-25, -35, 0]) cube([50, 70, 65]);
    translate([-26, -7, 12]) cube([52, 14, 54]);
    translate([0, 0, 29.25]) rotate([90, 0, 0]) cylinder(h = 72, d = 12.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-35, -6.75, 0]) cube([70, 13.5, 34]);
    translate([0, 0, 17]) rotate([90, 0, 0]) cylinder(h = 15.5, d = 12.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 86, d = 12, center = true);
  translate([-49, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 18);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 29.25]) rotate([0, 0, 90]) pin();
}

assembly();
