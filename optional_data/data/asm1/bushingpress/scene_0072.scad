$fn = 32;

// ------------------------------------------------------------------------
// Bushed housing: 80 x 80 x 80 mm housing, bushing d33.2
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module housing() {
  difference() {
    translate([-40, -40, 0]) cube([80, 80, 80]);
    translate([0, 0, 40]) rotate([0, 90, 0]) cylinder(h = 82, d = 34, center = true);
  }
}

// --- part 2 ---
module bushing() {
  difference() {
    union() {
      cylinder(h = 6, d = 46);
      translate([0, 0, 6]) cylinder(h = 72, d = 33.2);
    }
    translate([0, 0, -1]) cylinder(h = 80, d = 16.8);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -58.375]) cylinder(h = 116.75, d = 16);
}

// --- part 4 ---
module cover() {
  difference() {
    cylinder(h = 8, d = 70);
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
  translate([-46.25, 0, 40]) rotate([0, 90, 0]) bushing();
  translate([-3.875, 0, 40]) rotate([0, 90, 0]) shaft();
  translate([40.25, 0, 40]) rotate([0, 90, 0]) cover();
  translate([48.5, 0, 40]) rotate([0, 90, 0]) washer();
}

assembly();
