$fn = 32;

// ----------------------------------------------------------------------
// Finned heat sink: 45 x 50 mm base, 18 mm fins
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 45;              // base width
base_d = 50;              // base depth
base_t = 5;               // base thickness
fin_h = 18;               // fin height above the base
holes_d = 3.17;           // fixing holes
hole_x = 23.91;           // hole offset in x
hole_y = 19.41;           // hole offset in y
fin_t = 2.4;              // fin thickness
fin_pitch = 9.4;          // fin pitch
fin_count = 5;            // number of fins
fin_x0 = 3.7;             // first fin offset
flange_w = 59;            // flange plate width
flange_t = 3;             // flange plate thickness

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
  for (hx = [-23.91, 23.91]) {
    for (hy = [-19.41, 19.41]) {
      translate([base_w / 2 + hx, base_d / 2 + hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
