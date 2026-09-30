$fn = 32;

// ------------------------------------------------------------------------
// Shaft with rings and collars: d20 shaft, 4 rings
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module shaft() {
  translate([0, 0, -38.375]) cylinder(h = 76.75, d = 20);
}

// --- part 2 ---
module collar_a() {
  difference() {
    cylinder(h = 12, d = 54);
    translate([0, 0, -1]) cylinder(h = 14, d = 20.8);
    translate([0, 0, 6]) rotate([90, 0, 0]) cylinder(h = 56, d = 5, center = true);
  }
}

// --- part 3 ---
module spacer_a() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 44);
      translate([0, 0, -1]) cylinder(h = 14, d = 20.8);
    }
}

// --- part 4 ---
module spacer_b() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 12, d = 44);
      translate([0, 0, -1]) cylinder(h = 14, d = 20.8);
    }
}

// --- part 5 ---
module collar_b() {
  difference() {
    cylinder(h = 12, d = 54);
    translate([0, 0, -1]) cylinder(h = 14, d = 20.8);
    translate([0, 0, 6]) rotate([90, 0, 0]) cylinder(h = 56, d = 5, center = true);
  }
}

// --- assembly ---
module assembly() {
  translate([-15.625, 0, 0]) rotate([0, 90, 0]) shaft();
  translate([-40, 0, 0]) rotate([0, 90, 0]) collar_a();
  translate([-27.75, 0, 0]) rotate([0, 90, 0]) spacer_a();
  translate([-15.5, 0, 0]) rotate([0, 90, 0]) spacer_b();
  translate([-3.25, 0, 0]) rotate([0, 90, 0]) collar_b();
}

assembly();
