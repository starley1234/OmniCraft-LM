$fn = 32;

// ------------------------------------------------------------------------
// Clevis joint: 80 mm clevis, pin d8
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module clevis() {
  difference() {
    translate([-40, -25, 0]) cube([80, 50, 75]);
    translate([-41, -9, 12]) cube([82, 18, 64]);
    translate([0, 0, 32.25]) rotate([90, 0, 0]) cylinder(h = 52, d = 8.8, center = true);
  }
}

// --- part 2 ---
module eye() {
  difference() {
    translate([-60, -8.75, 0]) cube([120, 17.5, 40]);
    translate([0, 0, 20]) rotate([90, 0, 0]) cylinder(h = 19.5, d = 8.8, center = true);
  }
}

// --- part 3 ---
module pin() {
  rotate([0, 90, 0]) cylinder(h = 136, d = 8, center = true);
  translate([-74, 0, 0]) rotate([0, 90, 0]) cylinder(h = 7, d = 14);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) clevis();
  translate([0, 0, 12.25]) rotate([0, 0, 0]) eye();
  translate([0, 0, 32.25]) rotate([0, 0, 90]) pin();
}

assembly();
