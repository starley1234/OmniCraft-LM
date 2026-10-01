$fn = 32;

// ----------------------------------------------------------------------
// Rib bracket: 3-gusset L bracket
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 60;              // foot length, X
base_w = 60;              // foot width, Y
base_t = 6;               // foot thickness
plate_t = 6;              // upright plate thickness
plate_h = 60;             // overall height
gus_l = 24;               // gusset leg along the foot
gus_h = 24;               // gusset height
gus_t = 4;                // gusset thickness
gus_edge = 6;             // gusset margin from the foot edge
n_gus = 3;                // gusset count

gus_pitch = (base_w - 2 * gus_edge - gus_t) / (n_gus - 1);  // gusset pitch

union() {
  cube([base_l, base_w, base_t]);
  translate([base_l - plate_t, 0, base_t - 1])
    cube([plate_t, base_w, plate_h - base_t + 1]);
  for (i = [0 : n_gus - 1])
    translate([base_l - plate_t - gus_l, gus_edge + i * gus_pitch, base_t - 1])
      rotate([-90, 0, 0])
        linear_extrude(height = gus_t)
          polygon(points = [[0, 0], [gus_l + 1, 0], [0, -gus_h]]);
}
