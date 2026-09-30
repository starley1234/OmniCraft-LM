$fn = 32;

// ------------------------------------------------------------------------
// Bushed housing: 80 x 60 x 70 mm housing, bushing d25.2
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    translate([-40, -30, 0]) cube([80, 60, 70]);
    translate([0, 0, 35]) rotate([0, 90, 0]) cylinder(h = 82, d = 26, center = true);
  }
}

// --- part 2 ---
module bushing() {
  difference() {
    union() {
      cylinder(h = 8, d = 38);
      translate([0, 0, 8]) cylinder(h = 72, d = 25.2);
    }
    translate([0, 0, -1]) cylinder(h = 82, d = 16.8);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -65.25]) cylinder(h = 130.5, d = 16);
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
  translate([-48.25, 0, 35]) rotate([0, 90, 0]) bushing();
  translate([1, 0, 35]) rotate([0, 90, 0]) shaft();
  translate([40.25, 0, 35]) rotate([0, 90, 0]) cover();
}

assembly();
