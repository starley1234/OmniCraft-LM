$fn = 32;

// ----------------------------------------------------------------------
// Deck eye: 32 mm eye on a 48 mm base
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 48;              // base length
base_w = 32;              // base width
base_t = 6;               // base thickness
eye_r = 16;               // eye outside radius
eye_bore = 22;            // eye bore diameter
eye_w = 12;               // eye thickness
eye_z = 19;               // eye centre height
holes_d = 6.35;           // fixing holes
hole_x = 16;              // fixing hole spacing

difference() {
  union() {
    translate([-24, -16, 0]) cube([base_l, base_w, base_t]);
    /* eye standing upright, its foot sunk 3 mm into the base */
    translate([0, -6, 19]) rotate([-90, 0, 0]) cylinder(h = 12, d = 32);
  }
  /* eye bore, 2.5 mm clear of both faces */
  translate([0, -8.5, 19]) rotate([-90, 0, 0]) cylinder(h = 17, d = 22);
  translate([-16, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([16, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
