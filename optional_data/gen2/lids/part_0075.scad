$fn = 32;

// ----------------------------------------------------------------------
// Enclosure lid: 100 x 100 x 8 mm, 4 bolt holes
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 100;             // lid length, X
width = 100;              // lid width, Y
plate_t = 8;              // lid plate thickness
bolt_d = 3.4;             // bolt clearance
boss_lip = 3;             // bolt hole inset from the corner
sink = 1;                 // overlap of the lip and ribs into the plate
lip_h = 5;                // lip height below the plate
lip_wall = 3;             // lip wall thickness

module plate() {
  cube([length, width, plate_t]);
  /* lip that drops into the housing opening, sunk into the plate */
  translate([lip_wall, lip_wall, -lip_h + sink]) cube([length - 2 * lip_wall, width - 2 * lip_wall, lip_h]);
}

difference() {
  plate();
  /* bolt pattern matching the corner bosses */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -lip_h - 1])
      cylinder(h = plate_t + lip_h + 2, d = bolt_d);
}
