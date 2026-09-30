$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 60 mm clevis, pin d12
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-30, -35, 0]) cube([60, 70, 65]);
    translate([-31, -8, 12]) cube([62, 16, 54]);
    translate([0, 0, 26.25]) rotate([90, 0, 0]) cylinder(h = 72, d = 12.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-40, -7.75, 0]) cube([80, 15.5, 28]);
    translate([0, 0, 14]) rotate([90, 0, 0]) cylinder(h = 17.5, d = 12.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 96, d = 12, center = true);
  translate([-53, 0, 0]) rotate([0, 90, 0]) cylinder(h = 6, d = 18);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 26.25]) rotate([0, 0, 90]) pin();
}

assembly();
