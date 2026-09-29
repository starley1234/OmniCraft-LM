$fn = 32;

// ----------------------------------------------------------------------
// Deck eye: 32 mm eye on a 56 mm base
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 56;              // base length
base_w = 28;              // base width
base_t = 6;               // base thickness
eye_r = 16;               // eye outside radius
eye_bore = 20;            // eye bore diameter
eye_w = 14;               // eye thickness
eye_z = 19;               // eye centre height
holes_d = 7.94;           // fixing holes
hole_x = 20;              // fixing hole spacing

difference() {
  union() {
    translate([-28, -14, 0]) cube([base_l, base_w, base_t]);
    /* eye standing upright, its foot sunk 3 mm into the base */
    translate([0, -7, 19]) rotate([-90, 0, 0]) cylinder(h = 14, d = 32);
  }
  /* eye bore, 2.5 mm clear of both faces */
  translate([0, -9.5, 19]) rotate([-90, 0, 0]) cylinder(h = 19, d = 20);
  translate([-20, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([20, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
