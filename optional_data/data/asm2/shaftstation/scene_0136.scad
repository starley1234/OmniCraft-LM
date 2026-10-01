$fn = 32;

// ------------------------------------------------------------------------
// Shaft station: cup d38.8 x 45.5 mm, shaft d12
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing_cup() {
  difference() {
    cylinder(h = 45.5, d = 38.8);
    translate([0, 0, 8]) cylinder(h = 38.5, d = 26.8);
    translate([0, 0, -1]) cylinder(h = 10, d = 12.8);
  }
}

// --- part 2 ---
module bearing_lower() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 8, d = 26);
      translate([0, 0, -1]) cylinder(h = 10, d = 12.8);
    }
}

// --- part 3 ---
module bearing_upper() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 8, d = 26);
      translate([0, 0, -1]) cylinder(h = 10, d = 12.8);
    }
}

// --- part 4 ---
module station_shaft() {
  translate([0, 0, -26.25]) cylinder(h = 52.5, d = 12);
}

// --- part 5 ---
module station_cover() {
  difference() {
    cylinder(h = 5, d = 46.8);
    translate([0, 0, -1]) cylinder(h = 7, d = 12.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) housing_cup();
  color([0.20, 0.45, 0.75]) translate([0, 0, 8.25]) rotate([0, 0, 0]) bearing_lower();
  color([0.25, 0.62, 0.32]) translate([0, 0, 36.25]) rotate([0, 0, 0]) bearing_upper();
  color([0.92, 0.70, 0.18]) translate([0, 0, 34.5]) rotate([0, 0, 0]) station_shaft();
  color([0.58, 0.35, 0.70]) translate([0, 0, 45.75]) rotate([0, 0, 0]) station_cover();
}

assembly();
