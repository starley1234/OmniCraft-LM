$fn = 32;

// ----------------------------------------------------------------------
// Finned heat sink: 56 x 45 mm base, 35 mm fins
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 56;              // base width
base_d = 45;              // base depth
base_t = 4;               // base thickness
fin_h = 35;               // fin height above the base
holes_d = 6.35;           // fixing holes
hole_x = 20.83;           // hole offset in x
hole_y = 15.33;           // hole offset in y
fin_t = 2;                // fin thickness
fin_pitch = 9;            // fin pitch
fin_count = 6;            // number of fins
fin_x0 = 5.5;             // first fin offset

difference() {
  union() {
    cube([base_w, base_d, base_t]);
    for (i = [0 : fin_count - 1]) {
      translate([fin_x0 + i * fin_pitch, 0, base_t - 0.5]) cube([fin_t, base_d, fin_h + 0.5]);
    }
  }
  /* fixing holes through the base, 2.5 mm clear on both sides */
  for (hx = [-20.83, 20.83]) {
    for (hy = [-15.33, 15.33]) {
      translate([base_w / 2 + hx, base_d / 2 + hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
