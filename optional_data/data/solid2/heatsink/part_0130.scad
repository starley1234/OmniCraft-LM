$fn = 32;

// ----------------------------------------------------------------------
// Heatsink: cross fin block
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 90;              // base length, X
base_w = 60;              // base width, Y
base_t = 6;               // base plate thickness
fin_h = 20;               // fin height above the base
fin_t = 2;                // fin thickness
edge = 4;                 // margin from the base ends
pitch = 9;                // fin pitch
rib_pitch = 16;           // cross rib pitch

n_fins = floor((base_l - 2 * edge - fin_t) / pitch) + 1;  // fin count
total_h = base_t + fin_h - 1;  // overall height
n_ribs = floor((base_w - 2 * edge) / rib_pitch);  // rib count

union() {
  cube([base_l, base_w, base_t]);
  for (i = [0 : n_fins - 1])
    translate([edge + i * pitch, edge, base_t - 1])
      cube([fin_t, base_w - 2 * edge, fin_h]);
  for (i = [0 : n_ribs - 1])
    translate([edge, edge + 1 + i * rib_pitch, base_t - 1])
      cube([base_l - 2 * edge, fin_t, fin_h]);
}
