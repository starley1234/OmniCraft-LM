$fn = 32;

// ----------------------------------------------------------------------
// Finned heat sink: 50 x 50 mm base, 26 mm fins
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 50;              // base width
base_d = 50;              // base depth
base_t = 5;               // base thickness
fin_h = 26;               // fin height above the base
holes_d = 6.35;           // fixing holes
hole_x = 16.82;           // hole offset in x
hole_y = 16.82;           // hole offset in y
fin_t = 2;                // fin thickness
fin_pitch = 8;            // fin pitch
fin_count = 6;            // number of fins
fin_x0 = 5;               // first fin offset

difference() {
  union() {
    cube([base_w, base_d, base_t]);
    for (i = [0 : fin_count - 1]) {
      translate([fin_x0 + i * fin_pitch, 0, base_t - 0.5]) cube([fin_t, base_d, fin_h + 0.5]);
    }
  }
  /* fixing holes through the base, 2.5 mm clear on both sides */
  for (hx = [-16.82, 16.82]) {
    for (hy = [-16.82, 16.82]) {
      translate([base_w / 2 + hx, base_d / 2 + hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
