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
    translate([0, 0, 26.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 8.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-40, -8.75, 0]) cube([80, 17.5, 28]);
    translate([0, 0, 14]) rotate([90, 0, 0]) cylinder(h = 19.5, d = 8.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 96, d = 8, center = true);
  translate([-54, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 14);
}

// --- part 4 ---
module retainer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 14);
      translate([0, 0, -1]) cylinder(h = 4, d = 8.8);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 26.25]) rotate([0, 0, 90]) pin();
  translate([0, 50.25, 26.25]) rotate([90, 0, 0]) retainer();
}

assembly();
