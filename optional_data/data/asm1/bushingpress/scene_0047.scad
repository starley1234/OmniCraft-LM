$fn = 32;

// ------------------------------------------------------------------------
// Bushed housing: 90 x 60 x 70 mm housing, bushing d29.2
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    translate([-45, -30, 0]) cube([90, 60, 70]);
    translate([0, 0, 35]) rotate([0, 90, 0]) cylinder(h = 92, d = 30, center = true);
  }
}

// --- part 2 ---
module bushing() {
  difference() {
    union() {
      cylinder(h = 6, d = 42);
      translate([0, 0, 6]) cylinder(h = 82, d = 29.2);
    }
    translate([0, 0, -1]) cylinder(h = 90, d = 20.8);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -64.375]) cylinder(h = 128.75, d = 20);
}

// --- part 4 ---
module cover() {
  difference() {
    cylinder(h = 10, d = 50);
    translate([0, 0, -1]) cylinder(h = 12, d = 20.8);
  }
}

// --- part 5 ---
module washer() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 2, d = 32);
      translate([0, 0, -1]) cylinder(h = 4, d = 20.8);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) housing();
  translate([-51.25, 0, 35]) rotate([0, 90, 0]) bushing();
  translate([-2.875, 0, 35]) rotate([0, 90, 0]) shaft();
  translate([45.25, 0, 35]) rotate([0, 90, 0]) cover();
  translate([55.5, 0, 35]) rotate([0, 90, 0]) washer();
}

assembly();
