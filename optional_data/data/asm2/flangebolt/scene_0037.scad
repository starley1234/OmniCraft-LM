$fn = 32;

// ------------------------------------------------------------------------
// Bolted flange stack: flange d80, 8 bolts d10 on r30.09
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange_base() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 80);
      translate([0, 0, -1]) cylinder(h = 12, d = 40);
    }
}

// --- part 2 ---
module gasket() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.5, d = 76);
      translate([0, 0, -1]) cylinder(h = 3.5, d = 40.8);
    }
}

// --- part 3 ---
module flange_cover() {
  difference() {
    cylinder(h = 8, d = 80);
    translate([0, 0, -1]) cylinder(h = 10, d = 40.8);
    translate([30.09, 0, -1]) cylinder(h = 10, d = 10.8);
    translate([21.277, 21.277, -1]) cylinder(h = 10, d = 10.8);
    translate([0, 30.09, -1]) cylinder(h = 10, d = 10.8);
    translate([-21.277, 21.277, -1]) cylinder(h = 10, d = 10.8);
    translate([-30.09, 0, -1]) cylinder(h = 10, d = 10.8);
    translate([-21.277, -21.277, -1]) cylinder(h = 10, d = 10.8);
    translate([0, -30.09, -1]) cylinder(h = 10, d = 10.8);
    translate([21.277, -21.277, -1]) cylinder(h = 10, d = 10.8);
  }
}

// --- part 4 ---
module flange_bolt() {
  cylinder(h = 7, d = 16);
  translate([0, 0, -7.5]) cylinder(h = 7.5, d = 10);
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) flange_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 10.25]) rotate([0, 0, 0]) gasket();
  color([0.25, 0.62, 0.32]) translate([0, 0, 12]) rotate([0, 0, 0]) flange_cover();
  color([0.92, 0.70, 0.18]) translate([30.09, 0, 20.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.58, 0.35, 0.70]) translate([21.277, 21.277, 20.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.16, 0.66, 0.66]) translate([0, 30.09, 20.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.85, 0.48, 0.18]) translate([-21.277, 21.277, 20.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.55, 0.60, 0.65]) translate([-30.09, 0, 20.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.75, 0.30, 0.55]) translate([-21.277, -21.277, 20.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.42, 0.52, 0.28]) translate([0, -30.09, 20.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.80, 0.24, 0.20]) translate([21.277, -21.277, 20.25]) rotate([0, 0, 0]) flange_bolt();
}

assembly();
