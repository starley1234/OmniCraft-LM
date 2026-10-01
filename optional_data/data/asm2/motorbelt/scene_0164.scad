$fn = 32;

// ------------------------------------------------------------------------
// Motor belt drive: span 100 mm, pulleys d50, belt 12 mm wide
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-101, -40, 0]) cube([202, 80, 8]);
  }
}

// --- part 2 ---
module motor() {
  union() {
    translate([-22.5, -21, 0]) cube([45, 42, 45]);
    translate([25.5, 0, 22.5]) rotate([0, 90, 0]) cylinder(h = 6, d = 17.5, center = true);
  }
}

// --- part 3 ---
module drive_shaft() {
  translate([0, 0, -7.75]) cylinder(h = 15.5, d = 10);
}

// --- part 4 ---
module pulley_drive() {
  difference() {
    union() {
      cylinder(h = 16.5, d = 25);
      cylinder(h = 2, d = 50);
      translate([0, 0, 14.5]) cylinder(h = 2, d = 50);
    }
    translate([0, 0, -1]) cylinder(h = 18.5, d = 10.8);
  }
}

// --- part 5 ---
module idler_post() {
  translate([-12.5, -12.5, 0]) cube([25, 25, 51]);
}

// --- part 6 ---
module driven_shaft() {
  translate([0, 0, -7.75]) cylinder(h = 15.5, d = 10);
}

// --- part 7 ---
module pulley_driven() {
  difference() {
    union() {
      cylinder(h = 16.5, d = 25);
      cylinder(h = 2, d = 50);
      translate([0, 0, 14.5]) cylinder(h = 2, d = 50);
    }
    translate([0, 0, -1]) cylinder(h = 18.5, d = 10.8);
  }
}

// --- part 8 ---
module drive_belt() {
  difference() {
    linear_extrude(height = 12) polygon(points = concat([for (a = [90 : 45 : 270]) [28.4 * cos(a), 28.4 * sin(a)]], [for (a = [270 : 45 : 450]) [100 + 28.4 * cos(a), 28.4 * sin(a)]]));
    translate([0, 0, -1]) linear_extrude(height = 14) polygon(points = concat([for (a = [90 : 45 : 270]) [25.4 * cos(a), 25.4 * sin(a)]], [for (a = [270 : 45 : 450]) [100 + 25.4 * cos(a), 25.4 * sin(a)]]));
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([50, 0, 0]) rotate([0, 0, 0]) base_plate();
  color([0.20, 0.45, 0.75]) translate([0, 0, 30.75]) rotate([0, 270, 0]) motor();
  color([0.25, 0.62, 0.32]) translate([0, 0, 67.75]) rotate([0, 0, 0]) drive_shaft();
  color([0.92, 0.70, 0.18]) translate([0, 0, 59.5]) rotate([0, 0, 0]) pulley_drive();
  color([0.58, 0.35, 0.70]) translate([100, 0, 8.25]) rotate([0, 0, 0]) idler_post();
  color([0.16, 0.66, 0.66]) translate([100, 0, 67.75]) rotate([0, 0, 0]) driven_shaft();
  color([0.85, 0.48, 0.18]) translate([100, 0, 59.5]) rotate([0, 0, 0]) pulley_driven();
  color([0.55, 0.60, 0.65]) translate([0, 0, 61.75]) rotate([0, 0, 0]) drive_belt();
}

assembly();
