$fn = 32;

// ------------------------------------------------------------------------
// Lamp arm: column d14 x 70 mm, arm 80 mm
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module lamp_base() {
  difference() {
    translate([-40, -40, 0]) cube([80, 80, 8]);
  }
}

// --- part 2 ---
module lamp_column() {
  cylinder(h = 70, d = 14);
}

// --- part 3 ---
module head_fork() {
  difference() {
    translate([-18, -15, 0]) cube([36, 30, 28]);
    translate([-19, -5.4, 8]) cube([38, 10.8, 21]);
    translate([0, 0, 19.25]) rotate([90, 0, 0]) cylinder(h = 32, d = 10.8, center = true);
  }
}

// --- part 4 ---
module lamp_arm() {
  difference() {
    translate([-40, -5, 0]) cube([80, 10, 22]);
    translate([0, 0, 11]) rotate([90, 0, 0]) cylinder(h = 12, d = 10.8, center = true);
  }
}

// --- part 5 ---
module arm_pin() {
  rotate([0, 90, 0]) cylinder(h = 36, d = 10, center = true);
  translate([-21, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 14);
}

// --- part 6 ---
module arm_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 18);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 10.8);
    }
}

// --- part 7 ---
module arm_nut() {
  difference() {
    linear_extrude(height = 6) polygon(points = [[8.66, 0], [4.33, 7.5], [-4.33, 7.5], [-8.66, 0], [-4.33, -7.5], [4.33, -7.5]]);
    translate([0, 0, -1]) cylinder(h = 8, d = 10.8);
  }
}

// --- part 8 ---
module shade_bracket() {
  difference() {
    translate([-15, -15, 0]) cube([30, 30, 26]);
    translate([-16, -16, 6]) cube([25, 32, 21]);
    translate([12, 0, 15.6]) rotate([0, 90, 0]) cylinder(h = 8, d = 8, center = true);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) lamp_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 8.25]) rotate([0, 0, 0]) lamp_column();
  color([0.25, 0.62, 0.32]) translate([0, 0, 78.5]) rotate([0, 0, 0]) head_fork();
  color([0.92, 0.70, 0.18]) translate([0, 0, 86.75]) rotate([0, 0, 0]) lamp_arm();
  color([0.58, 0.35, 0.70]) translate([0, 0, 97.75]) rotate([0, 0, 90]) arm_pin();
  color([0.16, 0.66, 0.66]) translate([0, 19.85, 97.75]) rotate([90, 0, 0]) arm_washer();
  color([0.85, 0.48, 0.18]) translate([0, 26.1, 97.75]) rotate([90, 0, 0]) arm_nut();
  color([0.55, 0.60, 0.65]) translate([55.25, 0, 109]) rotate([0, 0, 0]) shade_bracket();
}

assembly();
