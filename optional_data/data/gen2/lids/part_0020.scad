$fn = 32;

// ----------------------------------------------------------------------
// Enclosure lid: 60 x 80 x 5 mm, 4 bolt holes
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // lid length, X
width = 80;               // lid width, Y
plate_t = 5;              // lid plate thickness
bolt_d = 3.4;             // bolt clearance
boss_lip = 5;             // bolt hole inset from the corner
sink = 1;                 // overlap of the lip and ribs into the plate
cs_d = 6.8;               // countersink diameter
cs_h = 1.7;               // countersink depth
rib_n = 4;                // stiffening ribs
rib_t = 2.5;              // rib thickness
rib_h = 8;                // rib height below the plate

module plate() {
  cube([length, width, plate_t]);
  /* stiffening ribs under the plate */
  for (i = [1 : rib_n]) translate([length * i / (rib_n + 1) - rib_t / 2, 0, -rib_h + sink]) cube([rib_t, width - 2 * 0, rib_h]);
}

difference() {
  plate();
  /* bolt pattern matching the corner bosses */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -0 - 1])
      cylinder(h = plate_t + 0 + 2, d = bolt_d);
  /* countersinks so the heads sit flush */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, plate_t - cs_h])
      cylinder(h = cs_h + 0.5, d = cs_d);
}
