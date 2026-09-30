$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 70 mm clevis, pin d12
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-35, -25, 0]) cube([70, 50, 75]);
    translate([-36, -7, 10]) cube([72, 14, 66]);
    translate([0, 0, 27.25]) rotate([90, 0, 0]) cylinder(h = 52, d = 12.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-55, -6.75, 0]) cube([110, 13.5, 34]);
    translate([0, 0, 17]) rotate([90, 0, 0]) cylinder(h = 15.5, d = 12.8, center = true);
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
  translate([0, 0, 10.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 27.25]) rotate([0, 0, 90]) pin();
  translate([0, 65.25, 27.25]) rotate([90, 0, 0]) retainer();
}

assembly();
