$fn = 32;

// ----------------------------------------------------------------------
// Ribbed panel: 1.4 mm panel
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_l = 100;            // panel length, X
panel_w = 40;             // panel width, Y
panel_t = 1.4;            // panel thickness, Z
rib_t = 1.4;              // rib thickness
rib_h = 12;               // rib height below the panel
ribs = 4;                 // number of ribs

total_h = panel_t + rib_h;  // overall height

union() {
  cube([panel_l, panel_w, panel_t]);
  for (i = [1 : ribs])
    translate([i * panel_l / (ribs + 1) - rib_t / 2, 0, -rib_h])
      cube([rib_t, panel_w, rib_h + panel_t]);
}
