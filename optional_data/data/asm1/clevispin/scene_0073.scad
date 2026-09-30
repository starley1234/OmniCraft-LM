$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 70 mm clevis, pin d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-35, -35, 0]) cube([70, 70, 75]);
    translate([-36, -9, 10]) cube([72, 18, 66]);
    translate([0, 0, 24.25]) rotate([90, 0, 0]) cylinder(h = 72, d = 8.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-50, -8.75, 0]) cube([100, 17.5, 28]);
    translate([0, 0, 14]) rotate([90, 0, 0]) cylinder(h = 19.5, d = 8.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 116, d = 8, center = true);
  translate([-64, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 14);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 10.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 24.25]) rotate([0, 0, 90]) pin();
}

assembly();
