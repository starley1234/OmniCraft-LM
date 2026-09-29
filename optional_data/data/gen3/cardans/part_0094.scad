$fn = 32;

// ----------------------------------------------------------------------
// Cardan cross: 68 mm span, 12.7 mm trunnions
// ----------------------------------------------------------------------

// --- parameters (mm) ---
journal_d = 12.7;         // trunnion diameter
arm_len = 34;             // trunnion length from the centre
step_r = 4.32;            // step position from the centre
step_d = 9.2;             // journal diameter after the step
hub_d = 20.7;             // hub diameter
hub_h = 20.32;            // hub height
bore_d = 6.35;            // hub bore

difference() {
  union() {
    /* hub along the joint axis */
    cylinder(h = hub_h, d = hub_d, center = true);
    for (a = [0 : 90 : 270]) rotate([0, 0, a]) {
      /* trunnion, sunk into the hub */
      translate([hub_d / 4, 0, 0]) rotate([0, 90, 0]) cylinder(h = step_r + 2, d = journal_d);
      /* stepped journal out to the tip */
      translate([step_r - 0.5, 0, 0]) rotate([0, 90, 0]) cylinder(h = arm_len + 0.5 - step_r, d = step_d);
    }
  }
  /* lubrication bore through the hub, 2.5 mm clear on both sides */
  translate([0, 0, -hub_h / 2 - 2.5]) cylinder(h = hub_h + 5, d = bore_d);
}
