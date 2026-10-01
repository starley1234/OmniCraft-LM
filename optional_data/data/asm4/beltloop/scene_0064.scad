$fn = 32;

// ------------------------------------------------------------------------
// Flat belt drive loop: span 90 mm, pulleys d50, belt 2.5 mm thick
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module loop_bed() {
  difference() {
    translate([-78.75, -35.75, 0]) cube([157.5, 71.5, 12]);
  }
}

// --- part 2 ---
module belt_bush_a() {
  difference() {
    union() {
      cylinder(h = 3, d = 28);
      translate([0, 0, 3]) cylinder(h = 18, d = 20);
    }
    translate([0, 0, -1]) cylinder(h = 23, d = 10.8);
  }
}

// --- part 3 ---
module belt_bush_b() {
  difference() {
    union() {
      cylinder(h = 3, d = 28);
      translate([0, 0, 3]) cylinder(h = 18, d = 20);
    }
    translate([0, 0, -1]) cylinder(h = 23, d = 10.8);
  }
}

// --- part 4 ---
module belt_shaft_a() {
  translate([0, 0, -25.625]) cylinder(h = 51.25, d = 10);
}

// --- part 5 ---
module belt_shaft_b() {
  translate([0, 0, -25.625]) cylinder(h = 51.25, d = 10);
}

// --- part 6 ---
module belt_pulley_a() {
  difference() {
    union() {
      cylinder(h = 24, d = 18.8);
      cylinder(h = 4, d = 50);
      translate([0, 0, 20]) cylinder(h = 4, d = 50);
    }
    translate([0, 0, -1]) cylinder(h = 26, d = 10.8);
  }
}

// --- part 7 ---
module belt_pulley_b() {
  difference() {
    union() {
      cylinder(h = 24, d = 18.8);
      cylinder(h = 4, d = 50);
      translate([0, 0, 20]) cylinder(h = 4, d = 50);
    }
    translate([0, 0, -1]) cylinder(h = 26, d = 10.8);
  }
}

// --- part 8 ---
module drive_belt() {
  difference() {
    linear_extrude(height = 15.6) polygon(points = concat([for (a = [90 : 45 : 270]) [27.75 * cos(a), 27.75 * sin(a)]], [for (a = [270 : 45 : 450]) [90 + 27.75 * cos(a), 27.75 * sin(a)]]));
    translate([0, 0, -1]) linear_extrude(height = 17.6) polygon(points = concat([for (a = [90 : 45 : 270]) [25.25 * cos(a), 25.25 * sin(a)]], [for (a = [270 : 45 : 450]) [90 + 25.25 * cos(a), 25.25 * sin(a)]]));
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([0, 0, 0]) rotate([0, 0, 0]) loop_bed();
  color([0.20, 0.45, 0.75]) translate([-45, 0, 12.25]) rotate([0, 0, 0]) belt_bush_a();
  color([0.25, 0.62, 0.32]) translate([45, 0, 12.25]) rotate([0, 0, 0]) belt_bush_b();
  color([0.92, 0.70, 0.18]) translate([-45, 0, 37.875]) rotate([0, 0, 0]) belt_shaft_a();
  color([0.58, 0.35, 0.70]) translate([45, 0, 37.875]) rotate([0, 0, 0]) belt_shaft_b();
  color([0.16, 0.66, 0.66]) translate([-45, 0, 33.5]) rotate([0, 0, 0]) belt_pulley_a();
  color([0.85, 0.48, 0.18]) translate([45, 0, 33.5]) rotate([0, 0, 0]) belt_pulley_b();
  color([0.55, 0.60, 0.65]) translate([-45, 0, 37.7]) rotate([0, 0, 0]) drive_belt();
}

assembly();
