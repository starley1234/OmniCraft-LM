$fn = 32;

// ------------------------------------------------------------------------
// Bolted flange stack: flange d100, 8 bolts d10 on r33.36
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module flange_base() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 8, d = 100);
      translate([0, 0, -1]) cylinder(h = 10, d = 40);
    }
}

// --- part 2 ---
module gasket() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.5, d = 96);
      translate([0, 0, -1]) cylinder(h = 3.5, d = 40.8);
    }
}

// --- part 3 ---
module flange_cover() {
  difference() {
    cylinder(h = 8, d = 100);
    translate([0, 0, -1]) cylinder(h = 10, d = 40.8);
    translate([33.36, 0, -1]) cylinder(h = 10, d = 10.8);
    translate([23.589, 23.589, -1]) cylinder(h = 10, d = 10.8);
    translate([0, 33.36, -1]) cylinder(h = 10, d = 10.8);
    translate([-23.589, 23.589, -1]) cylinder(h = 10, d = 10.8);
    translate([-33.36, 0, -1]) cylinder(h = 10, d = 10.8);
    translate([-23.589, -23.589, -1]) cylinder(h = 10, d = 10.8);
    translate([0, -33.36, -1]) cylinder(h = 10, d = 10.8);
    translate([23.589, -23.589, -1]) cylinder(h = 10, d = 10.8);
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
  color([0.20, 0.45, 0.75]) translate([0, 0, 8.25]) rotate([0, 0, 0]) gasket();
  color([0.25, 0.62, 0.32]) translate([0, 0, 10]) rotate([0, 0, 0]) flange_cover();
  color([0.92, 0.70, 0.18]) translate([33.36, 0, 18.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.58, 0.35, 0.70]) translate([23.589, 23.589, 18.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.16, 0.66, 0.66]) translate([0, 33.36, 18.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.85, 0.48, 0.18]) translate([-23.589, 23.589, 18.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.55, 0.60, 0.65]) translate([-33.36, 0, 18.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.75, 0.30, 0.55]) translate([-23.589, -23.589, 18.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.42, 0.52, 0.28]) translate([0, -33.36, 18.25]) rotate([0, 0, 0]) flange_bolt();
  color([0.80, 0.24, 0.20]) translate([23.589, -23.589, 18.25]) rotate([0, 0, 0]) flange_bolt();
}

assembly();
