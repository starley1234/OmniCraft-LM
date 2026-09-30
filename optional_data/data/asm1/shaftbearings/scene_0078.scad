$fn = 32;

// ------------------------------------------------------------------------
// Bearing housing: housing d70, two bearings and a shaft
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    cylinder(h = 45, d = 70);
    translate([0, 0, 10]) cylinder(h = 36, d = 60);
    translate([0, 0, -1]) cylinder(h = 12, d = 15.8);
  }
}

// --- part 2 ---
module bearing_lower() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 59.2);
      translate([0, 0, -1]) cylinder(h = 12, d = 15.8);
    }
}

// --- part 3 ---
module bearing_upper() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 59.2);
      translate([0, 0, -1]) cylinder(h = 12, d = 15.8);
    }
}

// --- part 4 ---
module spacer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 53.2);
      translate([0, 0, -1]) cylinder(h = 12, d = 15.8);
    }
}

// --- part 5 ---
module shaft() {
  translate([0, 0, -36.25]) cylinder(h = 72.5, d = 15);
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) housing();
  translate([0, 0, 10.25]) rotate([0, 0, 0]) bearing_lower();
  translate([0, 0, 45.25]) rotate([0, 0, 0]) bearing_upper();
  translate([0, 0, 55.5]) rotate([0, 0, 0]) spacer();
  translate([0, 0, 41.25]) rotate([0, 0, 0]) shaft();
}

assembly();
