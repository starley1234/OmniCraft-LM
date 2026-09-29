$fn = 32;

// ----------------------------------------------------------------------
// Enclosure lid: 60 x 40 x 6 mm, 4 bolt holes
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // lid length, X
width = 40;               // lid width, Y
plate_t = 6;              // lid plate thickness
bolt_d = 5.5;             // bolt clearance
boss_lip = 4;             // bolt hole inset from the corner
sink = 1;                 // overlap of the lip and ribs into the plate
lip_h = 5;                // lip height below the plate
lip_wall = 2;             // lip wall thickness
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
}
