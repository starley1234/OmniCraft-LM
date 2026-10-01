$fn = 32;

// ------------------------------------------------------------------------
// Shaft station: cup d34.8 x 43.5 mm, shaft d12
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing_cup() {
  difference() {
    cylinder(h = 43.5, d = 34.8);
    translate([0, 0, 6]) cylinder(h = 38.5, d = 24.8);
    translate([0, 0, -1]) cylinder(h = 8, d = 12.8);
  }
}

// --- part 2 ---
module bearing_lower() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 24);
      translate([0, 0, -1]) cylinder(h = 12, d = 12.8);
    }
}

// --- part 3 ---
module bearing_upper() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 24);
      translate([0, 0, -1]) cylinder(h = 12, d = 12.8);
    }
}

// --- part 4 ---
module station_shaft() {
  translate([0, 0, -24.75]) cylinder(h = 49.5, d = 12);
}

// --- part 5 ---
module station_cover() {
  difference() {
    cylinder(h = 6, d = 40.8);
    translate([0, 0, -1]) cylinder(h = 8, d = 12.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) housing_cup();
  color([0.20, 0.45, 0.75]) translate([0, 0, 6.25]) rotate([0, 0, 0]) bearing_lower();
  color([0.25, 0.62, 0.32]) translate([0, 0, 32.25]) rotate([0, 0, 0]) bearing_upper();
  color([0.92, 0.70, 0.18]) translate([0, 0, 31]) rotate([0, 0, 0]) station_shaft();
  color([0.58, 0.35, 0.70]) translate([0, 0, 43.75]) rotate([0, 0, 0]) station_cover();
}

assembly();
