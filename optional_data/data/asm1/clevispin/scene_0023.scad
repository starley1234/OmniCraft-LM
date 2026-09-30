$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 80 mm clevis, pin d12
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-40, -30, 0]) cube([80, 60, 65]);
    translate([-41, -9, 10]) cube([82, 18, 56]);
    translate([0, 0, 30.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 12.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-55, -8.75, 0]) cube([110, 17.5, 40]);
    translate([0, 0, 20]) rotate([90, 0, 0]) cylinder(h = 19.5, d = 12.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 126, d = 12, center = true);
  translate([-68, 0, 0]) rotate([0, 90, 0]) cylinder(h = 6, d = 18);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 10.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 30.25]) rotate([0, 0, 90]) pin();
}

assembly();
