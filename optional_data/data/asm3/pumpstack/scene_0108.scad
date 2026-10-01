$fn = 32;

// ------------------------------------------------------------------------
// Pump stack: housing d60 x 55 mm, rod d10
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module pump_base() {
  difference() {
    translate([-45, -45, 0]) cube([90, 90, 8]);
    translate([17.324, 17.324, -1]) cylinder(h = 10, d = 6.8);
    translate([-17.324, 17.324, -1]) cylinder(h = 10, d = 6.8);
    translate([-17.324, -17.324, -1]) cylinder(h = 10, d = 6.8);
    translate([17.324, -17.324, -1]) cylinder(h = 10, d = 6.8);
  }
}

// --- part 2 ---
module pump_housing() {
  difference() {
    cylinder(h = 55, d = 60);
    translate([0, 0, 8]) cylinder(h = 48, d = 50);
    translate([0, 0, -1]) cylinder(h = 10, d = 10.8);
  }
}

// --- part 3 ---
module pump_gasket() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 3, d = 49.2);
      translate([0, 0, -1]) cylinder(h = 5, d = 10.8);
    }
}

// --- part 4 ---
module pump_cover() {
  difference() {
    cylinder(h = 8, d = 60);
    translate([0, 0, -1]) cylinder(h = 10, d = 10.8);
    translate([17.324, 17.324, -1]) cylinder(h = 10, d = 6.8);
    translate([-17.324, 17.324, -1]) cylinder(h = 10, d = 6.8);
    translate([-17.324, -17.324, -1]) cylinder(h = 10, d = 6.8);
    translate([17.324, -17.324, -1]) cylinder(h = 10, d = 6.8);
  }
}

// --- part 5 ---
module pump_rod() {
  translate([0, 0, -37.125]) cylinder(h = 74.25, d = 10);
}

// --- part 6 ---
module rod_collar() {
  difference() {
    cylinder(h = 10, d = 18);
    translate([0, 0, -1]) cylinder(h = 12, d = 10.8);
    translate([0, 0, 5]) rotate([90, 0, 0]) cylinder(h = 20, d = 3.5, center = true);
  }
}

// --- part 7 ---
module cover_bolt() {
  cylinder(h = 5, d = 12);
  translate([0, 0, -8]) cylinder(h = 8, d = 6);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) pump_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 8.25]) rotate([0, 0, 0]) pump_housing();
  color([0.25, 0.62, 0.32]) translate([0, 0, 16.5]) rotate([0, 0, 0]) pump_gasket();
  color([0.92, 0.70, 0.18]) translate([0, 0, 63.5]) rotate([0, 0, 0]) pump_cover();
  color([0.58, 0.35, 0.70]) translate([0, 0, 46.375]) rotate([0, 0, 0]) pump_rod();
  color([0.16, 0.66, 0.66]) translate([0, 0, 74.5]) rotate([0, 0, 0]) rod_collar();
  color([0.85, 0.48, 0.18]) translate([17.324, 17.324, 71.75]) rotate([0, 0, 0]) cover_bolt();
  color([0.55, 0.60, 0.65]) translate([-17.324, 17.324, 71.75]) rotate([0, 0, 0]) cover_bolt();
  color([0.75, 0.30, 0.55]) translate([-17.324, -17.324, 71.75]) rotate([0, 0, 0]) cover_bolt();
  color([0.42, 0.52, 0.28]) translate([17.324, -17.324, 71.75]) rotate([0, 0, 0]) cover_bolt();
}

assembly();
