$fn = 32;

// ----------------------------------------------------------------------
// Micro pad: two-hole pad, 5-20 mm class
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pad_l = 16;               // pad length, X
pad_w = 12;               // pad width, Y
pad_t = 6;                // pad thickness, Z
hole_d = 3.5;             // hole diameter
hole_x = 7;               // X of the first hole centre
fit_tol = 0.02;           // tolerance for press fits, mm
free_tol = 0.2;           // tolerance for clearance fits, mm

difference() {
  cube([pad_l, pad_w, pad_t]);
  for (x = [hole_x, pad_l - hole_x])
    translate([x, pad_w / 2, -1])
      cylinder(h = pad_t + 2, d = hole_d);
}
