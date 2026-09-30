$fn = 32;

// ------------------------------------------------------------------------
// Pulley assembly: d60 pulley with a belt, shaft d20
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module support1() {
  difference() {
    translate([-20, -35, 0]) cube([40, 70, 76]);
    translate([0, 0, 45.6]) rotate([0, 90, 0]) cylinder(h = 42, d = 20.8, center = true);
  }
}

// --- part 2 ---
module support2() {
  difference() {
    translate([-20, -35, 0]) cube([40, 70, 76]);
    translate([0, 0, 45.6]) rotate([0, 90, 0]) cylinder(h = 42, d = 20.8, center = true);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -64.25]) cylinder(h = 128.5, d = 20);
}

// --- part 4 ---
module pulley() {
  difference() {
    union() {
      cylinder(h = 24, d = 30);
      cylinder(h = 5, d = 60);
      translate([0, 0, 19]) cylinder(h = 5, d = 60);
    }
    translate([0, 0, -1]) cylinder(h = 26, d = 20.8);
  }
}

// --- part 5 ---
module belt() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 13.5, d = 38);
      translate([0, 0, -1]) cylinder(h = 15.5, d = 30.5);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) support1();
  translate([64.5, 0, 0]) rotate([0, 0, 0]) support2();
  translate([32.25, 0, 45.6]) rotate([0, 90, 0]) shaft();
  translate([20.25, 0, 45.6]) rotate([0, 90, 0]) pulley();
  translate([25.5, 0, 45.6]) rotate([0, 90, 0]) belt();
}

assembly();
