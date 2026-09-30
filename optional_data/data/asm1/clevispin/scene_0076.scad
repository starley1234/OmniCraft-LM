$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 50 mm clevis, pin d10
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-25, -30, 0]) cube([50, 60, 75]);
    translate([-26, -8, 12]) cube([52, 16, 64]);
    translate([0, 0, 32.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 10.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-45, -7.75, 0]) cube([90, 15.5, 40]);
    translate([0, 0, 20]) rotate([90, 0, 0]) cylinder(h = 17.5, d = 10.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 106, d = 10, center = true);
  translate([-58, 0, 0]) rotate([0, 90, 0]) cylinder(h = 6, d = 16);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 32.25]) rotate([0, 0, 90]) pin();
}

assembly();
