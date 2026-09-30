$fn = 32;

// ------------------------------------------------------------------------
// Bushed housing: 70 x 60 x 80 mm housing, bushing d25.2
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    translate([-35, -30, 0]) cube([70, 60, 80]);
    translate([0, 0, 40]) rotate([0, 90, 0]) cylinder(h = 72, d = 26, center = true);
  }
}

// --- part 2 ---
module bushing() {
  difference() {
    union() {
      cylinder(h = 6, d = 38);
      translate([0, 0, 6]) cylinder(h = 62, d = 25.2);
    }
    translate([0, 0, -1]) cylinder(h = 70, d = 16.8);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -59.25]) cylinder(h = 118.5, d = 16);
}

// --- part 4 ---
module cover() {
  difference() {
    cylinder(h = 10, d = 50);
    translate([0, 0, -1]) cylinder(h = 12, d = 16.8);
  }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) housing();
  translate([-41.25, 0, 40]) rotate([0, 90, 0]) bushing();
  translate([2, 0, 40]) rotate([0, 90, 0]) shaft();
  translate([35.25, 0, 40]) rotate([0, 90, 0]) cover();
}

assembly();
