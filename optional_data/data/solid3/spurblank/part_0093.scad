$fn = 32;

// ----------------------------------------------------------------------
// Spur blank: plain gear blank
// ----------------------------------------------------------------------

// --- parameters (mm) ---
disc_r = 34;              // blank root radius
disc_t = 8;               // blank thickness
n_teeth = 10;             // stub tooth count
tooth_w = 6;              // tooth width at the root
tooth_h = 4;              // tooth height above the root
fit_tol = 0.02;           // tolerance for press fits, mm
free_tol = 0.2;           // tolerance for clearance fits, mm

out_r = disc_r + tooth_h;  // tip radius
bbox_x = 76.0;  // measured width over the teeth
bbox_y = 74.13;  // measured depth over the teeth

union() {
  cylinder(r = disc_r, h = disc_t);
  for (i = [0 : n_teeth - 1])
    rotate([0, 0, i * 360 / n_teeth])
      translate([disc_r - 1, -tooth_w / 2, 0])
        cube([tooth_h + 1, tooth_w, disc_t]);
}
