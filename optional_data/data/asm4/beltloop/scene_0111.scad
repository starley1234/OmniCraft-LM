$fn = 32;

// ------------------------------------------------------------------------
// Flat belt drive loop: span 110 mm, pulleys d50, belt 3 mm thick
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module loop_bed() {
  difference() {
    translate([-89.25, -36.25, 0]) cube([178.5, 72.5, 12]);
  }
}

// --- part 2 ---
module belt_bush_a() {
  difference() {
    union() {
      cylinder(h = 3, d = 28);
      translate([0, 0, 3]) cylinder(h = 22, d = 20);
    }
    translate([0, 0, -1]) cylinder(h = 27, d = 8.8);
  }
}

// --- part 3 ---
module belt_bush_b() {
  difference() {
    union() {
      cylinder(h = 3, d = 28);
      translate([0, 0, 3]) cylinder(h = 22, d = 20);
    }
    translate([0, 0, -1]) cylinder(h = 27, d = 8.8);
  }
}

// --- part 4 ---
module belt_shaft_a() {
  translate([0, 0, -25.625]) cylinder(h = 51.25, d = 8);
}

// --- part 5 ---
module belt_shaft_b() {
  translate([0, 0, -25.625]) cylinder(h = 51.25, d = 8);
}

// --- part 6 ---
module belt_pulley_a() {
  difference() {
    union() {
      cylinder(h = 20, d = 16.8);
      cylinder(h = 3, d = 50);
      translate([0, 0, 17]) cylinder(h = 3, d = 50);
    }
    translate([0, 0, -1]) cylinder(h = 22, d = 8.8);
  }
}

// --- part 7 ---
module belt_pulley_b() {
  difference() {
    union() {
      cylinder(h = 20, d = 16.8);
      cylinder(h = 3, d = 50);
      translate([0, 0, 17]) cylinder(h = 3, d = 50);
    }
    translate([0, 0, -1]) cylinder(h = 22, d = 8.8);
  }
}

// --- part 8 ---
module drive_belt() {
  difference() {
    linear_extrude(height = 13.6) polygon(points = concat([for (a = [90 : 45 : 270]) [28.25 * cos(a), 28.25 * sin(a)]], [for (a = [270 : 45 : 450]) [110 + 28.25 * cos(a), 28.25 * sin(a)]]));
    translate([0, 0, -1]) linear_extrude(height = 15.6) polygon(points = concat([for (a = [90 : 45 : 270]) [25.25 * cos(a), 25.25 * sin(a)]], [for (a = [270 : 45 : 450]) [110 + 25.25 * cos(a), 25.25 * sin(a)]]));
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) loop_bed();
  color([0.20, 0.45, 0.75]) translate([-55, 0, 12.25]) rotate([0, 0, 0]) belt_bush_a();
  color([0.25, 0.62, 0.32]) translate([55, 0, 12.25]) rotate([0, 0, 0]) belt_bush_b();
  color([0.92, 0.70, 0.18]) translate([-55, 0, 37.875]) rotate([0, 0, 0]) belt_shaft_a();
  color([0.58, 0.35, 0.70]) translate([55, 0, 37.875]) rotate([0, 0, 0]) belt_shaft_b();
  color([0.16, 0.66, 0.66]) translate([-55, 0, 37.5]) rotate([0, 0, 0]) belt_pulley_a();
  color([0.85, 0.48, 0.18]) translate([55, 0, 37.5]) rotate([0, 0, 0]) belt_pulley_b();
  color([0.55, 0.60, 0.65]) translate([-55, 0, 40.7]) rotate([0, 0, 0]) drive_belt();
}

assembly();
