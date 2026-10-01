$fn = 32;

// ----------------------------------------------------------------------
// Micro pad: drilled pad, 5-20 mm class
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pad_l = 16;               // pad length, X
pad_w = 10;               // pad width, Y
pad_t = 8;                // pad thickness, Z
hole_d = 4;               // through hole diameter

difference() {
  cube([pad_l, pad_w, pad_t]);
  translate([pad_l / 2, pad_w / 2, -1])
    cylinder(h = pad_t + 2, d = hole_d);
}
