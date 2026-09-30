$fn = 32;

// ------------------------------------------------------------------------
// Bushed housing: 90 x 70 x 70 mm housing, bushing d25.2
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    translate([-45, -35, 0]) cube([90, 70, 70]);
    translate([0, 0, 35]) rotate([0, 90, 0]) cylinder(h = 92, d = 26, center = true);
  }
}

// --- part 2 ---
module bushing() {
  difference() {
    union() {
      cylinder(h = 6, d = 38);
      translate([0, 0, 6]) cylinder(h = 82, d = 25.2);
    }
    translate([0, 0, -1]) cylinder(h = 90, d = 16.8);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -63.375]) cylinder(h = 126.75, d = 16);
}

// --- part 4 ---
module cover() {
  difference() {
    cylinder(h = 8, d = 60);
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
  translate([-51.25, 0, 35]) rotate([0, 90, 0]) bushing();
  translate([-3.875, 0, 35]) rotate([0, 90, 0]) shaft();
  translate([45.25, 0, 35]) rotate([0, 90, 0]) cover();
  translate([53.5, 0, 35]) rotate([0, 90, 0]) washer();
}

assembly();
