$fn = 32;

// ------------------------------------------------------------------------
// Bushed housing: 90 x 70 x 80 mm housing, bushing d33.2
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    translate([-45, -35, 0]) cube([90, 70, 80]);
    translate([0, 0, 40]) rotate([0, 90, 0]) cylinder(h = 92, d = 34, center = true);
  }
}

// --- part 2 ---
module bushing() {
  difference() {
    union() {
      cylinder(h = 8, d = 46);
      translate([0, 0, 8]) cylinder(h = 82, d = 33.2);
    }
    translate([0, 0, -1]) cylinder(h = 92, d = 16.8);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -70.25]) cylinder(h = 140.5, d = 16);
}

// --- part 4 ---
module cover() {
  difference() {
    cylinder(h = 10, d = 60);
    translate([0, 0, -1]) cylinder(h = 12, d = 16.8);
  }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) housing();
  translate([-53.25, 0, 40]) rotate([0, 90, 0]) bushing();
  translate([1, 0, 40]) rotate([0, 90, 0]) shaft();
  translate([45.25, 0, 40]) rotate([0, 90, 0]) cover();
}

assembly();
