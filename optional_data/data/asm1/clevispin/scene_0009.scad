$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 60 mm clevis, pin d10
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-30, -35, 0]) cube([60, 70, 65]);
    translate([-31, -7, 12]) cube([62, 14, 54]);
    translate([0, 0, 32.25]) rotate([90, 0, 0]) cylinder(h = 72, d = 10.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-40, -6.75, 0]) cube([80, 13.5, 40]);
    translate([0, 0, 20]) rotate([90, 0, 0]) cylinder(h = 15.5, d = 10.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 96, d = 10, center = true);
  translate([-54, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 16);
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
  translate([0, 0, 32.25]) rotate([0, 0, 90]) pin();
  translate([0, 50.25, 32.25]) rotate([90, 0, 0]) retainer();
}

assembly();
