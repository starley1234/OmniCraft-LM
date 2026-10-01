$fn = 32;

// ------------------------------------------------------------------------
// Bolted flange stack: flange d120, 4 bolts d8 on r34.13
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange_base() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 120);
      translate([0, 0, -1]) cylinder(h = 12, d = 40);
    }
}

// --- part 2 ---
module gasket() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 116);
      translate([0, 0, -1]) cylinder(h = 4, d = 40.8);
    }
}

// --- part 3 ---
module flange_cover() {
  difference() {
    cylinder(h = 8, d = 120);
    translate([0, 0, -1]) cylinder(h = 10, d = 40.8);
    translate([34.13, 0, -1]) cylinder(h = 10, d = 8.8);
    translate([0, 34.13, -1]) cylinder(h = 10, d = 8.8);
    translate([-34.13, 0, -1]) cylinder(h = 10, d = 8.8);
    translate([0, -34.13, -1]) cylinder(h = 10, d = 8.8);
  }
}

// --- part 4 ---
module flange_bolt() {
  cylinder(h = 5.6, d = 14);
  translate([0, 0, -7.5]) cylinder(h = 7.5, d = 8);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) flange_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 10.25]) rotate([0, 0, 0]) gasket();
  color([0.25, 0.62, 0.32]) translate([0, 0, 12.5]) rotate([0, 0, 0]) flange_cover();
  color([0.92, 0.70, 0.18]) translate([34.13, 0, 20.75]) rotate([0, 0, 0]) flange_bolt();
  color([0.58, 0.35, 0.70]) translate([0, 34.13, 20.75]) rotate([0, 0, 0]) flange_bolt();
  color([0.16, 0.66, 0.66]) translate([-34.13, 0, 20.75]) rotate([0, 0, 0]) flange_bolt();
  color([0.85, 0.48, 0.18]) translate([0, -34.13, 20.75]) rotate([0, 0, 0]) flange_bolt();
}

assembly();
