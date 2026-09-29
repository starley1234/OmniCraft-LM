$fn = 32;

// ----------------------------------------------------------------------
// Deck eye: 28 mm eye on a 56 mm base
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 56;              // base length
base_w = 24;              // base width
base_t = 10;              // base thickness
eye_r = 14;               // eye outside radius
eye_bore = 18;            // eye bore diameter
eye_w = 14;               // eye thickness
eye_z = 21;               // eye centre height
holes_d = 6.35;           // fixing holes
hole_x = 18;              // fixing hole spacing

difference() {
  union() {
    translate([-28, -12, 0]) cube([base_l, base_w, base_t]);
    /* eye standing upright, its foot sunk 3 mm into the base */
    translate([0, -7, 21]) rotate([-90, 0, 0]) cylinder(h = 14, d = 28);
  }
  /* eye bore, 2.5 mm clear of both faces */
  translate([0, -9.5, 21]) rotate([-90, 0, 0]) cylinder(h = 19, d = 18);
  translate([-18, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([18, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
