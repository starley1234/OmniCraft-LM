$fn = 32;

// ----------------------------------------------------------------------
// Finned heat sink: 56 x 40 mm base, 26 mm fins
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 56;              // base width
base_d = 40;              // base depth
base_t = 5;               // base thickness
fin_h = 26;               // fin height above the base
holes_d = 6.35;           // fixing holes
hole_x = 26.82;           // hole offset in x
hole_y = 11.82;           // hole offset in y
fin_t = 2.4;              // fin thickness
fin_pitch = 9.4;          // fin pitch
fin_count = 6;            // number of fins
fin_x0 = 4.5;             // first fin offset
flange_w = 70;            // flange plate width
flange_t = 4;             // flange plate thickness

difference() {
  union() {
    cube([base_w, base_d, base_t]);
    for (i = [0 : fin_count - 1]) {
      translate([fin_x0 + i * fin_pitch, 0, base_t - 0.5]) cube([fin_t, base_d, fin_h + 0.5]);
    }
    /* mounting flange, a wider plate sharing the base bottom */
    translate([(base_w - flange_w) / 2, 0, 0]) cube([flange_w, base_d, flange_t + 0.5]);
  }
  /* fixing holes through the base, 2.5 mm clear on both sides */
  for (hx = [-26.82, 26.82]) {
    for (hy = [-11.82, 11.82]) {
      translate([base_w / 2 + hx, base_d / 2 + hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
