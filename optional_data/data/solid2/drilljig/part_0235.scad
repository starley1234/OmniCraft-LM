$fn = 32;

// ----------------------------------------------------------------------
// Drill jig: two_boss jig
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness
boss_d = 18;              // guide boss diameter
boss_h = 10;              // boss height above the plate
guide_d = 6;              // guide hole diameter
boss_pitch = 40;          // boss pitch

n_boss = 2;  // guide bosses
boss_x0 = (plate_l - (n_boss - 1) * boss_pitch) / 2;  // first boss X
boss_top = plate_t - 1 + boss_h;  // boss crown height
total_h = boss_top;  // overall height

difference() {
  union() {
  cube([plate_l, plate_w, plate_t]);
  for (i = [0 : n_boss - 1])
    translate([boss_x0 + i * boss_pitch, plate_w / 2, plate_t - 1])
      cylinder(h = boss_h, d = boss_d);
  }
  for (i = [0 : n_boss - 1])
    translate([boss_x0 + i * boss_pitch, plate_w / 2, -1])
      cylinder(h = plate_t + boss_h, d = guide_d);
}
