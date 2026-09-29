$fn = 32;

// ----------------------------------------------------------------------
// Deck eye: 32 mm eye on a 48 mm base
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 48;              // base length
base_w = 24;              // base width
base_t = 8;               // base thickness
eye_r = 16;               // eye outside radius
eye_bore = 24;            // eye bore diameter
eye_w = 14;               // eye thickness
eye_z = 21;               // eye centre height
holes_d = 7.94;           // fixing holes
hole_x = 14;              // fixing hole spacing

difference() {
  union() {
    translate([-24, -12, 0]) cube([base_l, base_w, base_t]);
    /* eye standing upright, its foot sunk 3 mm into the base */
    translate([0, -7, 21]) rotate([-90, 0, 0]) cylinder(h = 14, d = 32);
  }
  /* eye bore, 2.5 mm clear of both faces */
  translate([0, -9.5, 21]) rotate([-90, 0, 0]) cylinder(h = 19, d = 24);
  translate([-14, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([14, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
