$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 60 mm clevis, pin d12
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-30, -25, 0]) cube([60, 50, 55]);
    translate([-31, -8, 12]) cube([62, 16, 44]);
    translate([0, 0, 32.25]) rotate([90, 0, 0]) cylinder(h = 52, d = 12.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-40, -7.75, 0]) cube([80, 15.5, 40]);
    translate([0, 0, 20]) rotate([90, 0, 0]) cylinder(h = 17.5, d = 12.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 96, d = 12, center = true);
  translate([-54, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 18);
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
  translate([0, 0, 32.25]) rotate([0, 0, 90]) pin();
  translate([0, 50.25, 32.25]) rotate([90, 0, 0]) retainer();
}

assembly();
