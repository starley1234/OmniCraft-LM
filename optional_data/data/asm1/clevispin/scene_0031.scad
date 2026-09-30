$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 50 mm clevis, pin d10
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-25, -30, 0]) cube([50, 60, 65]);
    translate([-26, -8, 12]) cube([52, 16, 54]);
    translate([0, 0, 26.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 10.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-40, -7.75, 0]) cube([80, 15.5, 28]);
    translate([0, 0, 14]) rotate([90, 0, 0]) cylinder(h = 17.5, d = 10.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 96, d = 10, center = true);
  translate([-53, 0, 0]) rotate([0, 90, 0]) cylinder(h = 6, d = 16);
}

// --- part 4 ---
module retainer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 16);
      translate([0, 0, -1]) cylinder(h = 4, d = 10.8);
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
