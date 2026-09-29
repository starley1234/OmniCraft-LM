$fn = 32;

// ----------------------------------------------------------------------
// Enclosure lid: 120 x 50 x 5 mm, 4 bolt holes
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 120;             // lid length, X
width = 50;               // lid width, Y
plate_t = 5;              // lid plate thickness
bolt_d = 5.5;             // bolt clearance
boss_lip = 5;             // bolt hole inset from the corner
sink = 1;                 // overlap of the lip and ribs into the plate
lip_h = 3;                // lip height below the plate
lip_wall = 2.5;           // lip wall thickness
cs_d = 8.9;               // countersink diameter
cs_h = 2.23;              // countersink depth
label_h = 1.2;            // raised marking pad

module plate() {
  cube([length, width, plate_t]);
  /* lip that drops into the housing opening, sunk into the plate */
  translate([lip_wall, lip_wall, -lip_h + sink]) cube([length - 2 * lip_wall, width - 2 * lip_wall, lip_h]);
  /* raised marking pad on top, sunk 1 mm into the plate */
  translate([length * 0.08, width * 0.28, plate_t - 1]) cube([length * 0.4, width * 0.44, label_h + 1]);
}

difference() {
  plate();
  /* bolt pattern matching the corner bosses */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -lip_h - 1])
      cylinder(h = plate_t + lip_h + 2, d = bolt_d);
  /* countersinks so the heads sit flush */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, plate_t - cs_h])
      cylinder(h = cs_h + 0.5, d = cs_d);
}
