$fn = 32;

// ----------------------------------------------------------------------
// Micro post: flanged post, 5-20 mm class
// ----------------------------------------------------------------------

// --- parameters (mm) ---
post_d = 7;               // post diameter
post_h = 8;               // post height above the flange
flange_d = 16;            // flange diameter
flange_t = 2;             // flange thickness
bore_d = 2.5;             // through bore

total_h = post_h + flange_t;  // overall height

difference() {
  union() {
    cylinder(h = flange_t, d = flange_d);
    translate([0, 0, flange_t]) cylinder(h = post_h, d = post_d);
  }
  translate([0, 0, -1]) cylinder(h = total_h + 2, d = bore_d);
}
