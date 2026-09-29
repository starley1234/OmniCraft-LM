$fn = 32;

// ----------------------------------------------------------------------
// Cardan cross: 76 mm span, 9.53 mm trunnions
// ----------------------------------------------------------------------

// --- parameters (mm) ---
journal_d = 9.53;         // trunnion diameter
arm_len = 38;             // trunnion length from the centre
step_r = 3.24;            // step position from the centre
step_d = 6.53;            // journal diameter after the step
hub_d = 15.53;            // hub diameter
hub_h = 13.33;            // hub height
bore_d = 4;               // hub bore
flat_d = 1;               // depth of the journal flat
flat_len = 10.64;         // length of the journal flat

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
  /* machined flat on each journal tip */
  for (a = [0 : 90 : 270]) rotate([0, 0, a]) {
    translate([arm_len - flat_len, -step_d, step_d / 2 - flat_d]) cube([flat_len + 0.5, 2 * step_d, flat_d + 2.5]);
  }
}
