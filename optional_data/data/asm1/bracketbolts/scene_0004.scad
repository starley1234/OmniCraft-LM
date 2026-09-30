$fn = 32;

// ------------------------------------------------------------------------
// Bolted bracket: 100 x 60 mm bracket with 2 bolt joints
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module bracket() {
  difference() {
    translate([-50, -30, 0]) cube([100, 60, 60]);
    translate([-51, -31, 8]) cube([89, 62, 53]);
    translate([44, 0, 32]) rotate([0, 90, 0]) cylinder(h = 14, d = 6.8, center = true);
    translate([44, 0, 48]) rotate([0, 90, 0]) cylinder(h = 14, d = 6.8, center = true);
  }
}

// --- part 2 ---
module bolt1() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -21.86]) cylinder(h = 21.86, d = 6);
}

// --- part 3 ---
module washer1() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 14);
      translate([0, 0, -1]) cylinder(h = 4, d = 6.8);
    }
}

// --- part 4 ---
module bolt2() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -21.86]) cylinder(h = 21.86, d = 6);
}

// --- part 5 ---
module washer2() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 14);
      translate([0, 0, -1]) cylinder(h = 4, d = 6.8);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) bracket();
  translate([50.25, 0, 32]) rotate([0, 90, 0]) bolt1();
  translate([35.75, 0, 32]) rotate([0, 90, 0]) washer1();
  translate([50.25, 0, 48]) rotate([0, 90, 0]) bolt2();
  translate([35.75, 0, 48]) rotate([0, 90, 0]) washer2();
}

assembly();
