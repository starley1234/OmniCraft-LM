$fn = 32;

// ------------------------------------------------------------------------
// Pulley assembly: d70 pulley with a belt, shaft d16
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module support1() {
  difference() {
    translate([-20, -30, 0]) cube([40, 60, 76]);
    translate([0, 0, 45.6]) rotate([0, 90, 0]) cylinder(h = 42, d = 16.8, center = true);
  }
}

// --- part 2 ---
module support2() {
  difference() {
    translate([-20, -30, 0]) cube([40, 60, 76]);
    translate([0, 0, 45.6]) rotate([0, 90, 0]) cylinder(h = 42, d = 16.8, center = true);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -68.25]) cylinder(h = 136.5, d = 16);
}

// --- part 4 ---
module pulley() {
  difference() {
    union() {
      cylinder(h = 32, d = 34);
      cylinder(h = 6, d = 70);
      translate([0, 0, 26]) cylinder(h = 6, d = 70);
    }
    translate([0, 0, -1]) cylinder(h = 34, d = 16.8);
  }
}

// --- part 5 ---
module belt() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 19.5, d = 42);
      translate([0, 0, -1]) cylinder(h = 21.5, d = 34.5);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) support1();
  translate([72.5, 0, 0]) rotate([0, 0, 0]) support2();
  translate([36.25, 0, 45.6]) rotate([0, 90, 0]) shaft();
  translate([20.25, 0, 45.6]) rotate([0, 90, 0]) pulley();
  translate([26.5, 0, 45.6]) rotate([0, 90, 0]) belt();
}

assembly();
