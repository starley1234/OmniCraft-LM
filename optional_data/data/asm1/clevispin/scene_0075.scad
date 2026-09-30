$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 80 mm clevis, pin d10
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-40, -30, 0]) cube([80, 60, 55]);
    translate([-41, -7, 12]) cube([82, 14, 44]);
    translate([0, 0, 29.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 10.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-60, -6.75, 0]) cube([120, 13.5, 34]);
    translate([0, 0, 17]) rotate([90, 0, 0]) cylinder(h = 15.5, d = 10.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 136, d = 10, center = true);
  translate([-73, 0, 0]) rotate([0, 90, 0]) cylinder(h = 6, d = 16);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 29.25]) rotate([0, 0, 90]) pin();
}

assembly();
