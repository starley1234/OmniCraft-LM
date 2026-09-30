$fn = 32;

// ------------------------------------------------------------------------
// Shaft with rings and collars: d25 shaft, 4 rings
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module shaft() {
  translate([0, 0, -40.375]) cylinder(h = 80.75, d = 25);
}

// --- part 2 ---
module collar_a() {
  difference() {
    cylinder(h = 16, d = 47);
    translate([0, 0, -1]) cylinder(h = 18, d = 25.8);
    translate([0, 0, 8]) rotate([90, 0, 0]) cylinder(h = 49, d = 5, center = true);
  }
}

// --- part 3 ---
module spacer_a() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 41);
      translate([0, 0, -1]) cylinder(h = 12, d = 25.8);
    }
}

// --- part 4 ---
module spacer_b() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 10, d = 41);
      translate([0, 0, -1]) cylinder(h = 12, d = 25.8);
    }
}

// --- part 5 ---
module collar_b() {
  difference() {
    cylinder(h = 16, d = 47);
    translate([0, 0, -1]) cylinder(h = 18, d = 25.8);
    translate([0, 0, 8]) rotate([90, 0, 0]) cylinder(h = 49, d = 5, center = true);
  }
}

// --- assembly ---
module assembly() {
  translate([-13.625, 0, 0]) rotate([0, 90, 0]) shaft();
  translate([-40, 0, 0]) rotate([0, 90, 0]) collar_a();
  translate([-23.75, 0, 0]) rotate([0, 90, 0]) spacer_a();
  translate([-13.5, 0, 0]) rotate([0, 90, 0]) spacer_b();
  translate([-3.25, 0, 0]) rotate([0, 90, 0]) collar_b();
}

assembly();
