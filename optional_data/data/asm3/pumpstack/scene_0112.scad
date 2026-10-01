$fn = 32;

// ------------------------------------------------------------------------
// Pump stack: housing d55 x 55 mm, rod d12
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module pump_base() {
  difference() {
    translate([-50, -50, 0]) cube([100, 100, 8]);
    translate([15.203, 15.203, -1]) cylinder(h = 10, d = 5.8);
    translate([-15.203, 15.203, -1]) cylinder(h = 10, d = 5.8);
    translate([-15.203, -15.203, -1]) cylinder(h = 10, d = 5.8);
    translate([15.203, -15.203, -1]) cylinder(h = 10, d = 5.8);
  }
}

// --- part 2 ---
module pump_housing() {
  difference() {
    cylinder(h = 55, d = 55);
    translate([0, 0, 6]) cylinder(h = 50, d = 43);
    translate([0, 0, -1]) cylinder(h = 8, d = 12.8);
  }
}

// --- part 3 ---
module pump_gasket() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 4, d = 42.2);
      translate([0, 0, -1]) cylinder(h = 6, d = 12.8);
    }
}

// --- part 4 ---
module pump_cover() {
  difference() {
    cylinder(h = 10, d = 55);
    translate([0, 0, -1]) cylinder(h = 12, d = 12.8);
    translate([15.203, 15.203, -1]) cylinder(h = 12, d = 5.8);
    translate([-15.203, 15.203, -1]) cylinder(h = 12, d = 5.8);
    translate([-15.203, -15.203, -1]) cylinder(h = 12, d = 5.8);
    translate([15.203, -15.203, -1]) cylinder(h = 12, d = 5.8);
  }
}

// --- part 5 ---
module pump_rod() {
  translate([0, 0, -38.125]) cylinder(h = 76.25, d = 12);
}

// --- part 6 ---
module rod_collar() {
  difference() {
    cylinder(h = 10, d = 20);
    translate([0, 0, -1]) cylinder(h = 12, d = 12.8);
    translate([0, 0, 5]) rotate([90, 0, 0]) cylinder(h = 22, d = 3.5, center = true);
  }
}

// --- part 7 ---
module cover_bolt() {
  cylinder(h = 5, d = 11);
  translate([0, 0, -10]) cylinder(h = 10, d = 5);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) pump_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 8.25]) rotate([0, 0, 0]) pump_housing();
  color([0.25, 0.62, 0.32]) translate([0, 0, 14.5]) rotate([0, 0, 0]) pump_gasket();
  color([0.92, 0.70, 0.18]) translate([0, 0, 63.5]) rotate([0, 0, 0]) pump_cover();
  color([0.58, 0.35, 0.70]) translate([0, 0, 47.375]) rotate([0, 0, 0]) pump_rod();
  color([0.16, 0.66, 0.66]) translate([0, 0, 76.5]) rotate([0, 0, 0]) rod_collar();
  color([0.85, 0.48, 0.18]) translate([15.203, 15.203, 73.75]) rotate([0, 0, 0]) cover_bolt();
  color([0.55, 0.60, 0.65]) translate([-15.203, 15.203, 73.75]) rotate([0, 0, 0]) cover_bolt();
  color([0.75, 0.30, 0.55]) translate([-15.203, -15.203, 73.75]) rotate([0, 0, 0]) cover_bolt();
  color([0.42, 0.52, 0.28]) translate([15.203, -15.203, 73.75]) rotate([0, 0, 0]) cover_bolt();
}

assembly();
