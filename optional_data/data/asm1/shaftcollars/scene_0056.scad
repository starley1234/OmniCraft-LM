$fn = 32;

// ------------------------------------------------------------------------
// Shaft with rings and collars: d25 shaft, 3 rings
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module shaft() {
  translate([0, 0, -30.25]) cylinder(h = 60.5, d = 25);
}

// --- part 2 ---
module spacer_a() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 45);
      translate([0, 0, -1]) cylinder(h = 12, d = 25.8);
    }
}

// --- part 3 ---
module spacer_b() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 45);
      translate([0, 0, -1]) cylinder(h = 12, d = 25.8);
    }
}

// --- part 4 ---
module collar_a() {
  difference() {
    cylinder(h = 12, d = 51);
    translate([0, 0, -1]) cylinder(h = 14, d = 25.8);
    translate([0, 0, 6]) rotate([90, 0, 0]) cylinder(h = 53, d = 5, center = true);
  }
}

// --- assembly ---
module assembly() {
  translate([-23.75, 0, 0]) rotate([0, 90, 0]) shaft();
  translate([-40, 0, 0]) rotate([0, 90, 0]) spacer_a();
  translate([-29.75, 0, 0]) rotate([0, 90, 0]) spacer_b();
  translate([-19.5, 0, 0]) rotate([0, 90, 0]) collar_a();
}

assembly();
