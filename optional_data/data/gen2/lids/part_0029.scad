$fn = 32;

// ----------------------------------------------------------------------
// Enclosure lid: 140 x 60 x 6 mm, 4 bolt holes
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // lid length, X
width = 60;               // lid width, Y
plate_t = 6;              // lid plate thickness
bolt_d = 4.5;             // bolt clearance
boss_lip = 4;             // bolt hole inset from the corner
sink = 1;                 // overlap of the lip and ribs into the plate
rib_n = 4;                // stiffening ribs
rib_t = 2.5;              // rib thickness
rib_h = 4;                // rib height below the plate
label_h = 1.2;            // raised marking pad

module plate() {
  cube([length, width, plate_t]);
  /* stiffening ribs under the plate */
  for (i = [1 : rib_n]) translate([length * i / (rib_n + 1) - rib_t / 2, 0, -rib_h + sink]) cube([rib_t, width - 2 * 0, rib_h]);
  /* raised marking pad on top, sunk 1 mm into the plate */
  translate([length * 0.08, width * 0.28, plate_t - 1]) cube([length * 0.4, width * 0.44, label_h + 1]);
}

difference() {
  plate();
  /* bolt pattern matching the corner bosses */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -0 - 1])
      cylinder(h = plate_t + 0 + 2, d = bolt_d);
}
