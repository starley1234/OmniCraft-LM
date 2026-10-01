$fn = 32;

// ------------------------------------------------------------------------
// Motor belt drive: span 110 mm, pulleys d40, belt 10 mm wide
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-101, -39, 0]) cube([202, 78, 10]);
  }
}

// --- part 2 ---
module motor() {
  union() {
    translate([-22.5, -24, 0]) cube([45, 48, 40]);
    translate([25.5, 0, 20]) rotate([0, 90, 0]) cylinder(h = 6, d = 14, center = true);
  }
}

// --- part 3 ---
module drive_shaft() {
  translate([0, 0, -6.75]) cylinder(h = 13.5, d = 8);
}

// --- part 4 ---
module pulley_drive() {
  difference() {
    union() {
      cylinder(h = 14.5, d = 20);
      cylinder(h = 2, d = 40);
      translate([0, 0, 12.5]) cylinder(h = 2, d = 40);
    }
    translate([0, 0, -1]) cylinder(h = 16.5, d = 8.8);
  }
}

// --- part 5 ---
module idler_post() {
  translate([-10, -10, 0]) cube([20, 20, 51]);
}

// --- part 6 ---
module driven_shaft() {
  translate([0, 0, -6.75]) cylinder(h = 13.5, d = 8);
}

// --- part 7 ---
module pulley_driven() {
  difference() {
    union() {
      cylinder(h = 14.5, d = 20);
      cylinder(h = 2, d = 40);
      translate([0, 0, 12.5]) cylinder(h = 2, d = 40);
    }
    translate([0, 0, -1]) cylinder(h = 16.5, d = 8.8);
  }
}

// --- part 8 ---
module drive_belt() {
  difference() {
    linear_extrude(height = 10) polygon(points = concat([for (a = [90 : 45 : 270]) [24.4 * cos(a), 24.4 * sin(a)]], [for (a = [270 : 45 : 450]) [110 + 24.4 * cos(a), 24.4 * sin(a)]]));
    translate([0, 0, -1]) linear_extrude(height = 12) polygon(points = concat([for (a = [90 : 45 : 270]) [20.4 * cos(a), 20.4 * sin(a)]], [for (a = [270 : 45 : 450]) [110 + 20.4 * cos(a), 20.4 * sin(a)]]));
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([55, 0, 0]) rotate([0, 0, 0]) base_plate();
  color([0.20, 0.45, 0.75]) translate([0, 0, 32.75]) rotate([0, 270, 0]) motor();
  color([0.25, 0.62, 0.32]) translate([0, 0, 68.75]) rotate([0, 0, 0]) drive_shaft();
  color([0.92, 0.70, 0.18]) translate([0, 0, 61.5]) rotate([0, 0, 0]) pulley_drive();
  color([0.58, 0.35, 0.70]) translate([110, 0, 10.25]) rotate([0, 0, 0]) idler_post();
  color([0.16, 0.66, 0.66]) translate([110, 0, 68.75]) rotate([0, 0, 0]) driven_shaft();
  color([0.85, 0.48, 0.18]) translate([110, 0, 61.5]) rotate([0, 0, 0]) pulley_driven();
  color([0.55, 0.60, 0.65]) translate([0, 0, 63.75]) rotate([0, 0, 0]) drive_belt();
}

assembly();
