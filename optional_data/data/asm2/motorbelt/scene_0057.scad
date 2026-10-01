$fn = 32;

// ------------------------------------------------------------------------
// Motor belt drive: span 80 mm, pulleys d60, belt 8 mm wide
// Every part is its own module, assembly() places every instance.
// ------------------------------------------------------------------------

// --- part 1 ---
module base_plate() {
  difference() {
    translate([-96, -45, 0]) cube([192, 90, 8]);
  }
}

// --- part 2 ---
module motor() {
  union() {
    translate([-25, -24, 0]) cube([50, 48, 50]);
    translate([28, 0, 25]) rotate([0, 90, 0]) cylinder(h = 6, d = 21, center = true);
  }
}

// --- part 3 ---
module drive_shaft() {
  translate([0, 0, -5.75]) cylinder(h = 11.5, d = 8);
}

// --- part 4 ---
module pulley_drive() {
  difference() {
    union() {
      cylinder(h = 12.5, d = 30);
      cylinder(h = 2, d = 60);
      translate([0, 0, 10.5]) cylinder(h = 2, d = 60);
    }
    translate([0, 0, -1]) cylinder(h = 14.5, d = 8.8);
  }
}

// --- part 5 ---
module idler_post() {
  translate([-15, -15, 0]) cube([30, 30, 56]);
}

// --- part 6 ---
module driven_shaft() {
  translate([0, 0, -5.75]) cylinder(h = 11.5, d = 8);
}

// --- part 7 ---
module pulley_driven() {
  difference() {
    union() {
      cylinder(h = 12.5, d = 30);
      cylinder(h = 2, d = 60);
      translate([0, 0, 10.5]) cylinder(h = 2, d = 60);
    }
    translate([0, 0, -1]) cylinder(h = 14.5, d = 8.8);
  }
}

// --- part 8 ---
module drive_belt() {
  difference() {
    linear_extrude(height = 8) polygon(points = concat([for (a = [90 : 45 : 270]) [33.4 * cos(a), 33.4 * sin(a)]], [for (a = [270 : 45 : 450]) [80 + 33.4 * cos(a), 33.4 * sin(a)]]));
    translate([0, 0, -1]) linear_extrude(height = 10) polygon(points = concat([for (a = [90 : 45 : 270]) [30.4 * cos(a), 30.4 * sin(a)]], [for (a = [270 : 45 : 450]) [80 + 30.4 * cos(a), 30.4 * sin(a)]]));
  }
}

// --- assembly ---
module assembly() {
  color([0.80, 0.24, 0.20]) translate([40, 0, 0]) rotate([0, 0, 0]) base_plate();
  color([0.20, 0.45, 0.75]) translate([0, 0, 33.25]) rotate([0, 270, 0]) motor();
  color([0.25, 0.62, 0.32]) translate([0, 0, 70.75]) rotate([0, 0, 0]) drive_shaft();
  color([0.92, 0.70, 0.18]) translate([0, 0, 64.5]) rotate([0, 0, 0]) pulley_drive();
  color([0.58, 0.35, 0.70]) translate([80, 0, 8.25]) rotate([0, 0, 0]) idler_post();
  color([0.16, 0.66, 0.66]) translate([80, 0, 70.75]) rotate([0, 0, 0]) driven_shaft();
  color([0.85, 0.48, 0.18]) translate([80, 0, 64.5]) rotate([0, 0, 0]) pulley_driven();
  color([0.55, 0.60, 0.65]) translate([0, 0, 66.75]) rotate([0, 0, 0]) drive_belt();
}

assembly();
