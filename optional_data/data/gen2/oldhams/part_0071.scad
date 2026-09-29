$fn = 32;

// ----------------------------------------------------------------------
// Oldham coupling disc: 30 x 18 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
disc_d = 30;              // disc diameter
disc_t = 8;               // disc thickness
tongue_w = 18;            // tongue width
tongue_h = 5;             // tongue height
bore_d = 14;              // centre lightening bore

module disc() {
  cylinder(h = disc_t, d = disc_d);
  /* tongue on the top face, sunk 1 mm into the disc */
  translate([-tongue_w / 2, -disc_d / 2, disc_t - 1]) cube([tongue_w, disc_d, tongue_h + 1]);
  /* slot wall on the bottom face, 90 degrees turned */
  translate([-disc_d / 2, -tongue_w / 2, -tongue_h]) cube([disc_d, tongue_w, tongue_h + 1]);
}

difference() {
  disc();
  translate([0, 0, -tongue_h - 1]) cylinder(h = disc_t + 2 * tongue_h + 2, d = bore_d);
}
