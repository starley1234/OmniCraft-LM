$fn = 32;

// ----------------------------------------------------------------------
// Heatsink: uniform fin block
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 80;              // base length, X
base_w = 45;              // base width, Y
base_t = 6;               // base plate thickness
fin_h = 30;               // fin height above the base
fin_t = 2.5;              // fin thickness
edge = 4;                 // margin from the base ends
pitch = 10;               // fin pitch
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.5;           // tolerance for clearance fits, mm

n_fins = floor((base_l - 2 * edge - fin_t) / pitch) + 1;  // fin count
total_h = base_t + fin_h - 1;  // overall height

union() {
  cube([base_l, base_w, base_t]);
  for (i = [0 : n_fins - 1])
    translate([edge + i * pitch, edge, base_t - 1])
      cube([fin_t, base_w - 2 * edge, fin_h]);
}
