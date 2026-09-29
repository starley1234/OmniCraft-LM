$fn = 32;

// ----------------------------------------------------------------------
// Finned heat sink: 50 x 45 mm base, 22 mm fins
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 50;              // base width
base_d = 45;              // base depth
base_t = 5;               // base thickness
fin_h = 22;               // fin height above the base
holes_d = 3.17;           // fixing holes
hole_x = 18.41;           // hole offset in x
hole_y = 15.91;           // hole offset in y
fin_t = 2.4;              // fin thickness
fin_pitch = 9.4;          // fin pitch
fin_count = 5;            // number of fins
fin_x0 = 6.2;             // first fin offset

difference() {
  union() {
    cube([base_w, base_d, base_t]);
    for (i = [0 : fin_count - 1]) {
      translate([fin_x0 + i * fin_pitch, 0, base_t - 0.5]) cube([fin_t, base_d, fin_h + 0.5]);
    }
  }
  /* fixing holes through the base, 2.5 mm clear on both sides */
  for (hx = [-18.41, 18.41]) {
    for (hy = [-15.91, 15.91]) {
      translate([base_w / 2 + hx, base_d / 2 + hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
