$fn = 32;

// ----------------------------------------------------------------------
// Finned heat sink: 60 x 40 mm base, 22 mm fins
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 60;              // base width
base_d = 40;              // base depth
base_t = 5;               // base thickness
fin_h = 22;               // fin height above the base
holes_d = 6.35;           // fixing holes
hole_x = 20.82;           // hole offset in x
hole_y = 10.82;           // hole offset in y
fin_t = 1.6;              // fin thickness
fin_pitch = 7.6;          // fin pitch
fin_count = 8;            // number of fins
fin_x0 = 3.4;             // first fin offset

difference() {
  union() {
    cube([base_w, base_d, base_t]);
    for (i = [0 : fin_count - 1]) {
      translate([fin_x0 + i * fin_pitch, 0, base_t - 0.5]) cube([fin_t, base_d, fin_h + 0.5]);
    }
  }
  /* fixing holes through the base, 2.5 mm clear on both sides */
  for (hx = [-20.82, 20.82]) {
    for (hy = [-10.82, 10.82]) {
      translate([base_w / 2 + hx, base_d / 2 + hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
