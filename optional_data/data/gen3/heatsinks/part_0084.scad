$fn = 32;

// ----------------------------------------------------------------------
// Finned heat sink: 45 x 50 mm base, 22 mm fins
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 45;              // base width
base_d = 50;              // base depth
base_t = 6;               // base thickness
fin_h = 22;               // fin height above the base
holes_d = 4.76;           // fixing holes
hole_x = 15.12;           // hole offset in x
hole_y = 17.62;           // hole offset in y
fin_t = 1.6;              // fin thickness
fin_pitch = 5.6;          // fin pitch
fin_count = 8;            // number of fins
fin_x0 = 2.9;             // first fin offset

difference() {
  union() {
    cube([base_w, base_d, base_t]);
    for (i = [0 : fin_count - 1]) {
      translate([fin_x0 + i * fin_pitch, 0, base_t - 0.5]) cube([fin_t, base_d, fin_h + 0.5]);
    }
  }
  /* fixing holes through the base, 2.5 mm clear on both sides */
  for (hx = [-15.12, 15.12]) {
    for (hy = [-17.62, 17.62]) {
      translate([base_w / 2 + hx, base_d / 2 + hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
