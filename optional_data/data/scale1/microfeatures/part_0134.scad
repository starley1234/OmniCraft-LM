$fn = 32;

// ----------------------------------------------------------------------
// Micro pad: drilled pad, 5-20 mm class
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pad_l = 18;               // pad length, X
pad_w = 14;               // pad width, Y
pad_t = 8;                // pad thickness, Z
hole_d = 4;               // through hole diameter
fit_tol = 0.05;           // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

difference() {
  cube([pad_l, pad_w, pad_t]);
  translate([pad_l / 2, pad_w / 2, -1])
    cylinder(h = pad_t + 2, d = hole_d);
}
