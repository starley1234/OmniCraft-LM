$fn = 32;

// ------------------------------------------------------------------------
// Shaft station: cup d36.8 x 46.5 mm, shaft d10
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing_cup() {
  difference() {
    cylinder(h = 46.5, d = 36.8);
    translate([0, 0, 5]) cylinder(h = 42.5, d = 24.8);
    translate([0, 0, -1]) cylinder(h = 7, d = 10.8);
  }
}

// --- part 2 ---
module bearing_lower() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 24);
      translate([0, 0, -1]) cylinder(h = 14, d = 10.8);
    }
}

// --- part 3 ---
module bearing_upper() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 24);
      translate([0, 0, -1]) cylinder(h = 14, d = 10.8);
    }
}

// --- part 4 ---
module station_shaft() {
  translate([0, 0, -27.75]) cylinder(h = 55.5, d = 10);
}

// --- part 5 ---
module station_cover() {
  difference() {
    cylinder(h = 8, d = 44.8);
    translate([0, 0, -1]) cylinder(h = 10, d = 10.8);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) housing_cup();
  color([0.20, 0.45, 0.75]) translate([0, 0, 5.25]) rotate([0, 0, 0]) bearing_lower();
  color([0.25, 0.62, 0.32]) translate([0, 0, 33.25]) rotate([0, 0, 0]) bearing_upper();
  color([0.92, 0.70, 0.18]) translate([0, 0, 33]) rotate([0, 0, 0]) station_shaft();
  color([0.58, 0.35, 0.70]) translate([0, 0, 46.75]) rotate([0, 0, 0]) station_cover();
}

assembly();
