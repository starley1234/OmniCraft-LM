$fn = 32;

// ----------------------------------------------------------------------
// Deck eye: 24 mm eye on a 40 mm base
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 40;              // base length
base_w = 32;              // base width
base_t = 8;               // base thickness
eye_r = 12;               // eye outside radius
eye_bore = 16;            // eye bore diameter
eye_w = 14;               // eye thickness
eye_z = 17;               // eye centre height
holes_d = 6.35;           // fixing holes
hole_x = 10;              // fixing hole spacing

difference() {
  union() {
    translate([-20, -16, 0]) cube([base_l, base_w, base_t]);
    /* eye standing upright, its foot sunk 3 mm into the base */
    translate([0, -7, 17]) rotate([-90, 0, 0]) cylinder(h = 14, d = 24);
  }
  /* eye bore, 2.5 mm clear of both faces */
  translate([0, -9.5, 17]) rotate([-90, 0, 0]) cylinder(h = 19, d = 16);
  translate([-10, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([10, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
