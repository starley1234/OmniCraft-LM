$fn = 32;

// ------------------------------------------------------------------------
// Flat belt drive loop: span 90 mm, pulleys d56, belt 3 mm thick
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module loop_bed() {
  difference() {
    translate([-82.25, -39.25, 0]) cube([164.5, 78.5, 10]);
  }
}

// --- part 2 ---
module belt_bush_a() {
  difference() {
    union() {
      cylinder(h = 3, d = 26);
      translate([0, 0, 3]) cylinder(h = 20, d = 18);
    }
    translate([0, 0, -1]) cylinder(h = 25, d = 8.8);
  }
}

// --- part 3 ---
module belt_bush_b() {
  difference() {
    union() {
      cylinder(h = 3, d = 26);
      translate([0, 0, 3]) cylinder(h = 20, d = 18);
    }
    translate([0, 0, -1]) cylinder(h = 25, d = 8.8);
  }
}

// --- part 4 ---
module belt_shaft_a() {
  translate([0, 0, -24.625]) cylinder(h = 49.25, d = 8);
}

// --- part 5 ---
module belt_shaft_b() {
  translate([0, 0, -24.625]) cylinder(h = 49.25, d = 8);
}

// --- part 6 ---
module belt_pulley_a() {
  difference() {
    union() {
      cylinder(h = 20, d = 16.8);
      cylinder(h = 3, d = 56);
      translate([0, 0, 17]) cylinder(h = 3, d = 56);
    }
    translate([0, 0, -1]) cylinder(h = 22, d = 8.8);
  }
}

// --- part 7 ---
module belt_pulley_b() {
  difference() {
    union() {
      cylinder(h = 20, d = 16.8);
      cylinder(h = 3, d = 56);
      translate([0, 0, 17]) cylinder(h = 3, d = 56);
    }
    translate([0, 0, -1]) cylinder(h = 22, d = 8.8);
  }
}

// --- part 8 ---
module drive_belt() {
  difference() {
    linear_extrude(height = 13.6) polygon(points = concat([for (a = [90 : 45 : 270]) [31.25 * cos(a), 31.25 * sin(a)]], [for (a = [270 : 45 : 450]) [90 + 31.25 * cos(a), 31.25 * sin(a)]]));
    translate([0, 0, -1]) linear_extrude(height = 15.6) polygon(points = concat([for (a = [90 : 45 : 270]) [28.25 * cos(a), 28.25 * sin(a)]], [for (a = [270 : 45 : 450]) [90 + 28.25 * cos(a), 28.25 * sin(a)]]));
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) loop_bed();
  color([0.20, 0.45, 0.75]) translate([-45, 0, 10.25]) rotate([0, 0, 0]) belt_bush_a();
  color([0.25, 0.62, 0.32]) translate([45, 0, 10.25]) rotate([0, 0, 0]) belt_bush_b();
  color([0.92, 0.70, 0.18]) translate([-45, 0, 34.875]) rotate([0, 0, 0]) belt_shaft_a();
  color([0.58, 0.35, 0.70]) translate([45, 0, 34.875]) rotate([0, 0, 0]) belt_shaft_b();
  color([0.16, 0.66, 0.66]) translate([-45, 0, 33.5]) rotate([0, 0, 0]) belt_pulley_a();
  color([0.85, 0.48, 0.18]) translate([45, 0, 33.5]) rotate([0, 0, 0]) belt_pulley_b();
  color([0.55, 0.60, 0.65]) translate([-45, 0, 36.7]) rotate([0, 0, 0]) drive_belt();
}

assembly();
