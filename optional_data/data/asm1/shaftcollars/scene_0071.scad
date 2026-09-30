$fn = 32;

// ------------------------------------------------------------------------
// Shaft with rings and collars: d15 shaft, 3 rings
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module shaft() {
  translate([0, 0, -34.25]) cylinder(h = 68.5, d = 15);
}

// --- part 2 ---
module spacer_a() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 31);
      translate([0, 0, -1]) cylinder(h = 14, d = 15.8);
    }
}

// --- part 3 ---
module spacer_b() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 31);
      translate([0, 0, -1]) cylinder(h = 14, d = 15.8);
    }
}

// --- part 4 ---
module collar_a() {
  difference() {
    cylinder(h = 16, d = 41);
    translate([0, 0, -1]) cylinder(h = 18, d = 15.8);
    translate([0, 0, 8]) rotate([90, 0, 0]) cylinder(h = 43, d = 5, center = true);
  }
}

// --- assembly ---
module assembly() {
  translate([-19.75, 0, 0]) rotate([0, 90, 0]) shaft();
  translate([-40, 0, 0]) rotate([0, 90, 0]) spacer_a();
  translate([-27.75, 0, 0]) rotate([0, 90, 0]) spacer_b();
  translate([-15.5, 0, 0]) rotate([0, 90, 0]) collar_a();
}

assembly();
