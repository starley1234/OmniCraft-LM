$fn = 32;

// ----------------------------------------------------------------------
// Micro pad: drilled pad, 5-20 mm class
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pad_l = 12;               // pad length, X
pad_w = 14;               // pad width, Y
pad_t = 5;                // pad thickness, Z
hole_d = 4;               // through hole diameter

difference() {
  cube([pad_l, pad_w, pad_t]);
  translate([pad_l / 2, pad_w / 2, -1])
    cylinder(h = pad_t + 2, d = hole_d);
}
