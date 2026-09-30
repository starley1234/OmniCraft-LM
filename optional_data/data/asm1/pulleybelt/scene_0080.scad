$fn = 32;

// ------------------------------------------------------------------------
// Pulley assembly: d78.2 pulley with a belt, shaft d16
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module support1() {
  difference() {
    translate([-20, -35, 0]) cube([40, 70, 66]);
    translate([0, 0, 39.6]) rotate([0, 90, 0]) cylinder(h = 42, d = 16.8, center = true);
  }
}

// --- part 2 ---
module support2() {
  difference() {
    translate([-20, -35, 0]) cube([40, 70, 66]);
    translate([0, 0, 39.6]) rotate([0, 90, 0]) cylinder(h = 42, d = 16.8, center = true);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -64.25]) cylinder(h = 128.5, d = 16);
}

// --- part 4 ---
module pulley() {
  difference() {
    union() {
      cylinder(h = 24, d = 34);
      cylinder(h = 5, d = 78.2);
      translate([0, 0, 19]) cylinder(h = 5, d = 78.2);
    }
    translate([0, 0, -1]) cylinder(h = 26, d = 16.8);
  }
}

// --- part 5 ---
module belt() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 13.5, d = 42);
      translate([0, 0, -1]) cylinder(h = 15.5, d = 34.5);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) support1();
  translate([64.5, 0, 0]) rotate([0, 0, 0]) support2();
  translate([32.25, 0, 39.6]) rotate([0, 90, 0]) shaft();
  translate([20.25, 0, 39.6]) rotate([0, 90, 0]) pulley();
  translate([25.5, 0, 39.6]) rotate([0, 90, 0]) belt();
}

assembly();
