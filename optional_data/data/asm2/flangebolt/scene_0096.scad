$fn = 32;

// ------------------------------------------------------------------------
// Bolted flange stack: flange d80, 4 bolts d6 on r25.48
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange_base() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 8, d = 80);
      translate([0, 0, -1]) cylinder(h = 10, d = 30);
    }
}

// --- part 2 ---
module gasket() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 76);
      translate([0, 0, -1]) cylinder(h = 4, d = 30.8);
    }
}

// --- part 3 ---
module flange_cover() {
  difference() {
    cylinder(h = 8, d = 80);
    translate([0, 0, -1]) cylinder(h = 10, d = 30.8);
    translate([25.48, 0, -1]) cylinder(h = 10, d = 6.8);
    translate([0, 25.48, -1]) cylinder(h = 10, d = 6.8);
    translate([-25.48, 0, -1]) cylinder(h = 10, d = 6.8);
    translate([0, -25.48, -1]) cylinder(h = 10, d = 6.8);
  }
}

// --- part 4 ---
module flange_bolt() {
  cylinder(h = 4.2, d = 12);
  translate([0, 0, -7.5]) cylinder(h = 7.5, d = 6);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) flange_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 8.25]) rotate([0, 0, 0]) gasket();
  color([0.25, 0.62, 0.32]) translate([0, 0, 10.5]) rotate([0, 0, 0]) flange_cover();
  color([0.92, 0.70, 0.18]) translate([25.48, 0, 18.75]) rotate([0, 0, 0]) flange_bolt();
  color([0.58, 0.35, 0.70]) translate([0, 25.48, 18.75]) rotate([0, 0, 0]) flange_bolt();
  color([0.16, 0.66, 0.66]) translate([-25.48, 0, 18.75]) rotate([0, 0, 0]) flange_bolt();
  color([0.85, 0.48, 0.18]) translate([0, -25.48, 18.75]) rotate([0, 0, 0]) flange_bolt();
}

assembly();
