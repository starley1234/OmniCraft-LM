$fn = 32;

// ----------------------------------------------------------------------
// Snap-fit latch: 2 arms, 18 mm tall, 3.6 mm undercut hooks
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_d = 52;              // base plate depth
base_h = 5;               // base plate thickness
span = 36;                // distance between opposite arms
arm_t = 3.6;              // arm thickness
arm_d = 8;                // arm width
height = 18;              // free arm length
head_len = 3.6;           // hook reach
head_h = 4;               // hook height
lead = 1.4;               // lead-in ramp thickness
bore_d = 5.4;             // base fixing bore
top_z = 23;               // height of the arm tips above the base

arms = 2;

difference() {
  union() {
    /* base plate, centred on the arm ring */
    translate([-26, -26, 0]) cube([base_d, base_d, base_h]);
    for (a = [0 : 360 / arms : 359]) rotate([0, 0, a]) {
    /* arm, sunk 0.5 mm into the base */
    translate([-arm_d / 2, span / 2 - arm_t / 2, base_h - 0.5]) cube([arm_d, arm_t, height + 0.5]);
    /* hook: a convex hull of a tall inner block and a thin outer lip
       gives a flat undercut below and a lead-in ramp on top */
    hull() {
      translate([-arm_d / 2, span / 2 + arm_t / 2 - 0.6, top_z - head_h]) cube([arm_d, lead + 0.4, head_h]);
      translate([-arm_d / 2, span / 2 + arm_t / 2 - 0.2, top_z - head_h]) cube([arm_d, head_len, lead]);
    }
    }
  }
  translate([0, 0, -2.5]) cylinder(h = base_h + 5, d = bore_d);
}
