$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 70 mm clevis, pin d12
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-35, -30, 0]) cube([70, 60, 75]);
    translate([-36, -7, 12]) cube([72, 14, 64]);
    translate([0, 0, 26.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 12.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-55, -6.75, 0]) cube([110, 13.5, 28]);
    translate([0, 0, 14]) rotate([90, 0, 0]) cylinder(h = 15.5, d = 12.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 126, d = 12, center = true);
  translate([-69, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 18);
}

// --- part 4 ---
module retainer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 18);
      translate([0, 0, -1]) cylinder(h = 4, d = 12.8);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 26.25]) rotate([0, 0, 90]) pin();
  translate([0, 65.25, 26.25]) rotate([90, 0, 0]) retainer();
}

assembly();
