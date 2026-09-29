$fn = 32;

// ----------------------------------------------------------------------
// Deck eye: 36 mm eye on a 40 mm base
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 40;              // base length
base_w = 28;              // base width
base_t = 10;              // base thickness
eye_r = 18;               // eye outside radius
eye_bore = 26;            // eye bore diameter
eye_w = 12;               // eye thickness
eye_z = 25;               // eye centre height
holes_d = 6.35;           // fixing holes
hole_x = 12;              // fixing hole spacing

difference() {
  union() {
    translate([-20, -14, 0]) cube([base_l, base_w, base_t]);
    /* eye standing upright, its foot sunk 3 mm into the base */
    translate([0, -6, 25]) rotate([-90, 0, 0]) cylinder(h = 12, d = 36);
  }
  /* eye bore, 2.5 mm clear of both faces */
  translate([0, -8.5, 25]) rotate([-90, 0, 0]) cylinder(h = 17, d = 26);
  translate([-12, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([12, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
