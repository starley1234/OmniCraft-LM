$fn = 32;

// ------------------------------------------------------------------------
// Pulley assembly: d70 pulley with a belt, shaft d15
// Every part is its own module, assembly() places them once.
// ------------------------------------------------------------------------

// --- part 1 ---
module support1() {
  difference() {
    translate([-20, -30, 0]) cube([40, 60, 66]);
    translate([0, 0, 39.6]) rotate([0, 90, 0]) cylinder(h = 42, d = 15.8, center = true);
  }
}

// --- part 2 ---
module support2() {
  difference() {
    translate([-20, -30, 0]) cube([40, 60, 66]);
    translate([0, 0, 39.6]) rotate([0, 90, 0]) cylinder(h = 42, d = 15.8, center = true);
  }
}

// --- part 3 ---
module shaft() {
  translate([0, 0, -66.25]) cylinder(h = 132.5, d = 15);
}

// --- part 4 ---
module pulley() {
  difference() {
    union() {
      cylinder(h = 28, d = 33);
      cylinder(h = 6, d = 70);
      translate([0, 0, 22]) cylinder(h = 6, d = 70);
    }
    translate([0, 0, -1]) cylinder(h = 30, d = 15.8);
  }
}

// --- part 5 ---
module belt() {
  difference() {
      translate([0, 0, 0]) cylinder(h = 15.5, d = 38);
      translate([0, 0, -1]) cylinder(h = 17.5, d = 33.5);
    }
}

// --- assembly ---
module assembly() {
  translate([0, 0, 0]) rotate([0, 0, 0]) support1();
  translate([68.5, 0, 0]) rotate([0, 0, 0]) support2();
  translate([34.25, 0, 39.6]) rotate([0, 90, 0]) shaft();
  translate([20.25, 0, 39.6]) rotate([0, 90, 0]) pulley();
  translate([26.5, 0, 39.6]) rotate([0, 90, 0]) belt();
}

assembly();
