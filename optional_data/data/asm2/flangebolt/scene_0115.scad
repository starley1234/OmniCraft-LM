$fn = 32;

// ------------------------------------------------------------------------
// Bolted flange stack: flange d120, 4 bolts d10 on r45.7
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange_base() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 120);
      translate([0, 0, -1]) cylinder(h = 14, d = 40);
    }
}

// --- part 2 ---
module gasket() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.5, d = 116);
      translate([0, 0, -1]) cylinder(h = 3.5, d = 40.8);
    }
}

// --- part 3 ---
module flange_cover() {
  difference() {
    cylinder(h = 10, d = 120);
    translate([0, 0, -1]) cylinder(h = 12, d = 40.8);
    translate([45.7, 0, -1]) cylinder(h = 12, d = 10.8);
    translate([0, 45.7, -1]) cylinder(h = 12, d = 10.8);
    translate([-45.7, 0, -1]) cylinder(h = 12, d = 10.8);
    translate([0, -45.7, -1]) cylinder(h = 12, d = 10.8);
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
  color([0.20, 0.45, 0.75]) translate([0, 0, 12.25]) rotate([0, 0, 0]) gasket();
  color([0.25, 0.62, 0.32]) translate([0, 0, 14]) rotate([0, 0, 0]) flange_cover();
  color([0.92, 0.70, 0.18]) translate([45.7, 0, 24.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.58, 0.35, 0.70]) translate([0, 45.7, 24.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.16, 0.66, 0.66]) translate([-45.7, 0, 24.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.85, 0.48, 0.18]) translate([0, -45.7, 24.25]) rotate([0, 0, 0]) flange_bolt();
}

assembly();
