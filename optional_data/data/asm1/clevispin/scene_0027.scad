$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 70 mm clevis, pin d12
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-35, -35, 0]) cube([70, 70, 75]);
    translate([-36, -8, 10]) cube([72, 16, 66]);
    translate([0, 0, 30.25]) rotate([90, 0, 0]) cylinder(h = 72, d = 12.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-50, -7.75, 0]) cube([100, 15.5, 40]);
    translate([0, 0, 20]) rotate([90, 0, 0]) cylinder(h = 17.5, d = 12.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 116, d = 12, center = true);
  translate([-63, 0, 0]) rotate([0, 90, 0]) cylinder(h = 6, d = 18);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 10.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 30.25]) rotate([0, 0, 90]) pin();
}

assembly();
