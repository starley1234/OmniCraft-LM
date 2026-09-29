$fn = 32;

// ----------------------------------------------------------------------
// Finned heat sink: 50 x 45 mm base, 18 mm fins
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 50;              // base width
base_d = 45;              // base depth
base_t = 5;               // base thickness
fin_h = 18;               // fin height above the base
holes_d = 4.76;           // fixing holes
hole_x = 28.62;           // hole offset in x
hole_y = 15.12;           // hole offset in y
fin_t = 1.6;              // fin thickness
fin_pitch = 8.6;          // fin pitch
fin_count = 6;            // number of fins
fin_x0 = 3.5;             // first fin offset
flange_w = 72;            // flange plate width
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
  for (hx = [-28.62, 28.62]) {
    for (hy = [-15.12, 15.12]) {
      translate([base_w / 2 + hx, base_d / 2 + hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
