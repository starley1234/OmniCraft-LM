$fn = 32;

// ------------------------------------------------------------------------
// Bushed housing: 80 x 80 x 70 mm housing, bushing d29.2
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    translate([-40, -40, 0]) cube([80, 80, 70]);
    translate([0, 0, 35]) rotate([0, 90, 0]) cylinder(h = 82, d = 30, center = true);
  }
}

// --- part 2 ---
module bushing() {
  difference() {
    union() {
      cylinder(h = 8, d = 42);
      translate([0, 0, 8]) cylinder(h = 72, d = 29.2);
    }
    translate([0, 0, -1]) cylinder(h = 82, d = 15.8);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -60.375]) cylinder(h = 120.75, d = 15);
}

// --- part 4 ---
module cover() {
  difference() {
    cylinder(h = 10, d = 60);
    translate([0, 0, -1]) cylinder(h = 12, d = 15.8);
  }
}

// --- part 5 ---
module washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 27);
      translate([0, 0, -1]) cylinder(h = 4, d = 15.8);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) housing();
  translate([-48.25, 0, 35]) rotate([0, 90, 0]) bushing();
  translate([-3.875, 0, 35]) rotate([0, 90, 0]) shaft();
  translate([40.25, 0, 35]) rotate([0, 90, 0]) cover();
  translate([50.5, 0, 35]) rotate([0, 90, 0]) washer();
}

assembly();
