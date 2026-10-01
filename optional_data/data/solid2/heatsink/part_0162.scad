$fn = 32;

// ----------------------------------------------------------------------
// Heatsink: slotted fin block
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 100;             // base length, X
base_w = 45;              // base width, Y
base_t = 10;              // base plate thickness
fin_h = 40;               // fin height above the base
fin_t = 2.5;              // fin thickness
edge = 3;                 // margin from the base ends
pitch = 8;                // fin pitch
slot_w = 8;               // central slot width, Y
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

n_fins = floor((base_l - 2 * edge - fin_t) / pitch) + 1;  // fin count
total_h = base_t + fin_h - 1;  // overall height

difference() {
union() {
  cube([base_l, base_w, base_t]);
  for (i = [0 : n_fins - 1])
    translate([edge + i * pitch, edge, base_t - 1])
      cube([fin_t, base_w - 2 * edge, fin_h]);
}
  translate([-1, base_w / 2 - slot_w / 2, base_t - 0.5])
    cube([base_l + 2, slot_w, fin_h + 2]);
}
