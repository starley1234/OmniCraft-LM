$fn = 32;

// ----------------------------------------------------------------------
// Enclosure lid: 120 x 100 x 5 mm, 4 bolt holes
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 120;             // lid length, X
width = 100;              // lid width, Y
plate_t = 5;              // lid plate thickness
bolt_d = 4.5;             // bolt clearance
boss_lip = 3;             // bolt hole inset from the corner
sink = 1;                 // overlap of the lip and ribs into the plate

module plate() {
  cube([length, width, plate_t]);
}

difference() {
  plate();
  /* bolt pattern matching the corner bosses */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -0 - 1])
      cylinder(h = plate_t + 0 + 2, d = bolt_d);
}
