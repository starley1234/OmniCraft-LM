$fn = 32;

// ------------------------------------------------------------------------
// Lamp arm: column d16 x 50 mm, arm 70 mm
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module lamp_base() {
  difference() {
    translate([-40, -40, 0]) cube([80, 80, 10]);
  }
}

// --- part 2 ---
module lamp_column() {
  cylinder(h = 50, d = 16);
}

// --- part 3 ---
module head_fork() {
  difference() {
    translate([-15.75, -15, 0]) cube([31.5, 30, 30]);
    translate([-16.75, -5.4, 10]) cube([33.5, 10.8, 21]);
    translate([0, 0, 22.25]) rotate([90, 0, 0]) cylinder(h = 32, d = 8.8, center = true);
  }
}

// --- part 4 ---
module lamp_arm() {
  difference() {
    translate([-35, -5, 0]) cube([70, 10, 24]);
    translate([0, 0, 12]) rotate([90, 0, 0]) cylinder(h = 12, d = 8.8, center = true);
  }
}

// --- part 5 ---
module arm_pin() {
  rotate([0, 90, 0]) cylinder(h = 34, d = 8, center = true);
  translate([-20, 0, 0]) rotate([0, 90, 0]) cylinder(h = 4, d = 12);
}

// --- part 6 ---
module arm_washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 1.6, d = 16);
      translate([0, 0, -1]) cylinder(h = 3.6, d = 8.8);
    }
}

// --- part 7 ---
module arm_nut() {
  difference() {
    linear_extrude(height = 6) polygon(points = [[7.506, 0], [3.753, 6.5], [-3.753, 6.5], [-7.506, 0], [-3.753, -6.5], [3.753, -6.5]]);
    translate([0, 0, -1]) cylinder(h = 8, d = 8.8);
  }
}

// --- part 8 ---
module shade_bracket() {
  difference() {
    translate([-17, -17, 0]) cube([34, 34, 22]);
    translate([-18, -18, 6]) cube([29, 36, 17]);
    translate([14, 0, 13.2]) rotate([0, 90, 0]) cylinder(h = 8, d = 8, center = true);
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) lamp_base();
  color([0.20, 0.45, 0.75]) translate([0, 0, 10.25]) rotate([0, 0, 0]) lamp_column();
  color([0.25, 0.62, 0.32]) translate([0, 0, 60.5]) rotate([0, 0, 0]) head_fork();
  color([0.92, 0.70, 0.18]) translate([0, 0, 70.75]) rotate([0, 0, 0]) lamp_arm();
  color([0.58, 0.35, 0.70]) translate([0, 0, 82.75]) rotate([0, 0, 90]) arm_pin();
  color([0.16, 0.66, 0.66]) translate([0, 18.85, 82.75]) rotate([90, 0, 0]) arm_washer();
  color([0.85, 0.48, 0.18]) translate([0, 25.1, 82.75]) rotate([90, 0, 0]) arm_nut();
  color([0.55, 0.60, 0.65]) translate([52.25, 0, 95]) rotate([0, 0, 0]) shade_bracket();
}

assembly();
