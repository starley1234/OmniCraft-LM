$fn = 32;

// ------------------------------------------------------------------------
// Bearing housing: housing d70, two bearings and a shaft
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    cylinder(h = 55, d = 70);
    translate([0, 0, 10]) cylinder(h = 46, d = 58);
    translate([0, 0, -1]) cylinder(h = 12, d = 20.8);
  }
}

// --- part 2 ---
module bearing_lower() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 57.2);
      translate([0, 0, -1]) cylinder(h = 14, d = 20.8);
    }
}

// --- part 3 ---
module bearing_upper() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 57.2);
      translate([0, 0, -1]) cylinder(h = 14, d = 20.8);
    }
}

// --- part 4 ---
module spacer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 8, d = 51.2);
      translate([0, 0, -1]) cylinder(h = 10, d = 20.8);
    }
}

// --- part 5 ---
module shaft() {
  translate([0, 0, -41.25]) cylinder(h = 82.5, d = 20);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) housing();
  translate([0, 0, 10.25]) rotate([0, 0, 0]) bearing_lower();
  translate([0, 0, 55.25]) rotate([0, 0, 0]) bearing_upper();
  translate([0, 0, 67.5]) rotate([0, 0, 0]) spacer();
  translate([0, 0, 46.25]) rotate([0, 0, 0]) shaft();
}

assembly();
