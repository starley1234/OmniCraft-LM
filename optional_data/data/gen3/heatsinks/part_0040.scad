$fn = 32;

// ----------------------------------------------------------------------
// Finned heat sink: 40 x 45 mm base, 22 mm fins
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 40;              // base width
base_d = 45;              // base depth
base_t = 6;               // base thickness
fin_h = 22;               // fin height above the base
holes_d = 4.76;           // fixing holes
hole_x = 11.62;           // hole offset in x
hole_y = 14.12;           // hole offset in y
pin_d = 5;                // pin diameter
pin_pitch = 9;            // pin pitch
pin_nx = 4;               // pins along x
pin_ny = 5;               // pins along y

difference() {
  union() {
    cube([base_w, base_d, base_t]);
    for (ix = [0 : pin_nx - 1]) {
      for (iy = [0 : pin_ny - 1]) {
        translate([(base_w - (pin_nx - 1) * pin_pitch) / 2 + ix * pin_pitch, (base_d - (pin_ny - 1) * pin_pitch) / 2 + iy * pin_pitch, base_t - 0.5]) cylinder(h = fin_h + 0.5, d = pin_d);
      }
    }
  }
  /* fixing holes through the base, 2.5 mm clear on both sides */
  for (hx = [-11.62, 11.62]) {
    for (hy = [-14.12, 14.12]) {
      translate([base_w / 2 + hx, base_d / 2 + hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
