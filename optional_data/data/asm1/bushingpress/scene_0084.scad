$fn = 32;

// ------------------------------------------------------------------------
// Bushed housing: 70 x 70 x 70 mm housing, bushing d29.2
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    translate([-35, -35, 0]) cube([70, 70, 70]);
    translate([0, 0, 35]) rotate([0, 90, 0]) cylinder(h = 72, d = 30, center = true);
  }
}

// --- part 2 ---
module bushing() {
  difference() {
    union() {
      cylinder(h = 6, d = 42);
      translate([0, 0, 6]) cylinder(h = 62, d = 29.2);
    }
    translate([0, 0, -1]) cylinder(h = 70, d = 20.8);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -58.25]) cylinder(h = 116.5, d = 20);
}

// --- part 4 ---
module cover() {
  difference() {
    cylinder(h = 8, d = 60);
    translate([0, 0, -1]) cylinder(h = 10, d = 20.8);
  }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) housing();
  translate([-41.25, 0, 35]) rotate([0, 90, 0]) bushing();
  translate([1, 0, 35]) rotate([0, 90, 0]) shaft();
  translate([35.25, 0, 35]) rotate([0, 90, 0]) cover();
}

assembly();
