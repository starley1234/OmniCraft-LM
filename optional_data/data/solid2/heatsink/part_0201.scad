$fn = 32;

// ----------------------------------------------------------------------
// Heatsink: slotted fin block
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 70;              // base length, X
base_w = 70;              // base width, Y
base_t = 8;               // base plate thickness
fin_h = 30;               // fin height above the base
fin_t = 3;                // fin thickness
edge = 3;                 // margin from the base ends
pitch = 10;               // fin pitch
slot_w = 8;               // central slot width, Y

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
