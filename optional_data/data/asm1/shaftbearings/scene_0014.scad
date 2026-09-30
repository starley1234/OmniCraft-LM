$fn = 32;

// ------------------------------------------------------------------------
// Bearing housing: housing d80, two bearings and a shaft
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    cylinder(h = 65, d = 80);
    translate([0, 0, 8]) cylinder(h = 58, d = 68);
    translate([0, 0, -1]) cylinder(h = 10, d = 20.8);
  }
}

// --- part 2 ---
module bearing_lower() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 67.2);
      translate([0, 0, -1]) cylinder(h = 14, d = 20.8);
    }
}

// --- part 3 ---
module bearing_upper() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 67.2);
      translate([0, 0, -1]) cylinder(h = 14, d = 20.8);
    }
}

// --- part 4 ---
module spacer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 61.2);
      translate([0, 0, -1]) cylinder(h = 14, d = 20.8);
    }
}

// --- part 5 ---
module shaft() {
  translate([0, 0, -48.75]) cylinder(h = 97.5, d = 20);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) housing();
  translate([0, 0, 8.25]) rotate([0, 0, 0]) bearing_lower();
  translate([0, 0, 65.25]) rotate([0, 0, 0]) bearing_upper();
  translate([0, 0, 77.5]) rotate([0, 0, 0]) spacer();
  translate([0, 0, 52.75]) rotate([0, 0, 0]) shaft();
}

assembly();
