$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 70 mm clevis, pin d10
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-35, -30, 0]) cube([70, 60, 75]);
    translate([-36, -8, 10]) cube([72, 16, 66]);
    translate([0, 0, 27.25]) rotate([90, 0, 0]) cylinder(h = 62, d = 10.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-45, -7.75, 0]) cube([90, 15.5, 34]);
    translate([0, 0, 17]) rotate([90, 0, 0]) cylinder(h = 17.5, d = 10.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 106, d = 10, center = true);
  translate([-59, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 16);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 10.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 27.25]) rotate([0, 0, 90]) pin();
}

assembly();
