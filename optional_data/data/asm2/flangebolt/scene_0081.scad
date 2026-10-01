$fn = 32;

// ------------------------------------------------------------------------
// Bolted flange stack: flange d100, 4 bolts d10 on r37.92
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange_base() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 100);
      translate([0, 0, -1]) cylinder(h = 12, d = 50);
    }
}

// --- part 2 ---
module gasket() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 96);
      translate([0, 0, -1]) cylinder(h = 4, d = 50.8);
    }
}

// --- part 3 ---
module flange_cover() {
  difference() {
    cylinder(h = 10, d = 100);
    translate([0, 0, -1]) cylinder(h = 12, d = 50.8);
    translate([37.92, 0, -1]) cylinder(h = 12, d = 10.8);
    translate([0, 37.92, -1]) cylinder(h = 12, d = 10.8);
    translate([-37.92, 0, -1]) cylinder(h = 12, d = 10.8);
    translate([0, -37.92, -1]) cylinder(h = 12, d = 10.8);
  }
}

// --- part 4 ---
module flange_bolt() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -9.5]) cylinder(h = 9.5, d = 10);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) flange_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 10.25]) rotate([0, 0, 0]) gasket();
  color([0.25, 0.62, 0.32]) translate([0, 0, 12.5]) rotate([0, 0, 0]) flange_cover();
  color([0.92, 0.70, 0.18]) translate([37.92, 0, 22.75]) rotate([0, 0, 0]) flange_bolt();
  color([0.58, 0.35, 0.70]) translate([0, 37.92, 22.75]) rotate([0, 0, 0]) flange_bolt();
  color([0.16, 0.66, 0.66]) translate([-37.92, 0, 22.75]) rotate([0, 0, 0]) flange_bolt();
  color([0.85, 0.48, 0.18]) translate([0, -37.92, 22.75]) rotate([0, 0, 0]) flange_bolt();
}

assembly();
