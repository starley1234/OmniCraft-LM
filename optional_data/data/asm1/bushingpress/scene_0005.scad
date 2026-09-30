$fn = 32;

// ------------------------------------------------------------------------
// Bushed housing: 70 x 60 x 70 mm housing, bushing d29.2
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    translate([-35, -30, 0]) cube([70, 60, 70]);
    translate([0, 0, 35]) rotate([0, 90, 0]) cylinder(h = 72, d = 30, center = true);
  }
}

// --- part 2 ---
module bushing() {
  difference() {
    union() {
      cylinder(h = 8, d = 42);
      translate([0, 0, 8]) cylinder(h = 62, d = 29.2);
    }
    translate([0, 0, -1]) cylinder(h = 72, d = 16.8);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -54.375]) cylinder(h = 108.75, d = 16);
}

// --- part 4 ---
module cover() {
  difference() {
    cylinder(h = 8, d = 50);
    translate([0, 0, -1]) cylinder(h = 10, d = 16.8);
  }
}

// --- part 5 ---
module washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 28);
      translate([0, 0, -1]) cylinder(h = 4, d = 16.8);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) housing();
  translate([-43.25, 0, 35]) rotate([0, 90, 0]) bushing();
  translate([-4.875, 0, 35]) rotate([0, 90, 0]) shaft();
  translate([35.25, 0, 35]) rotate([0, 90, 0]) cover();
  translate([43.5, 0, 35]) rotate([0, 90, 0]) washer();
}

assembly();
