$fn = 32;

// ------------------------------------------------------------------------
// Shaft with rings and collars: d25 shaft, 3 rings
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module shaft() {
  translate([0, 0, -36.25]) cylinder(h = 72.5, d = 25);
}

// --- part 2 ---
module spacer_a() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 14, d = 45);
      translate([0, 0, -1]) cylinder(h = 16, d = 25.8);
    }
}

// --- part 3 ---
module spacer_b() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 14, d = 45);
      translate([0, 0, -1]) cylinder(h = 16, d = 25.8);
    }
}

// --- part 4 ---
module collar_a() {
  difference() {
    cylinder(h = 16, d = 51);
    translate([0, 0, -1]) cylinder(h = 18, d = 25.8);
    translate([0, 0, 8]) rotate([90, 0, 0]) cylinder(h = 53, d = 6, center = true);
  }
}

// --- assembly ---
module assembly() {
  translate([-17.75, 0, 0]) rotate([0, 90, 0]) shaft();
  translate([-40, 0, 0]) rotate([0, 90, 0]) spacer_a();
  translate([-25.75, 0, 0]) rotate([0, 90, 0]) spacer_b();
  translate([-11.5, 0, 0]) rotate([0, 90, 0]) collar_a();
}

assembly();
