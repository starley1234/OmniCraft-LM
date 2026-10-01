$fn = 32;

// ----------------------------------------------------------------------
// Micro pad: two-hole pad, 5-20 mm class
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pad_l = 14;               // pad length, X
pad_w = 12;               // pad width, Y
pad_t = 5;                // pad thickness, Z
hole_d = 3;               // hole diameter
hole_x = 6;               // X of the first hole centre

difference() {
  cube([pad_l, pad_w, pad_t]);
  for (x = [hole_x, pad_l - hole_x])
    translate([x, pad_w / 2, -1])
      cylinder(h = pad_t + 2, d = hole_d);
}
