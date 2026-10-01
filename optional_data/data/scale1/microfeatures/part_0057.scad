$fn = 32;

// ----------------------------------------------------------------------
// Micro post: flanged post, 5-20 mm class
// ----------------------------------------------------------------------

// --- parameters (mm) ---
post_d = 6;               // post diameter
post_h = 10;              // post height above the flange
flange_d = 12;            // flange diameter
flange_t = 3;             // flange thickness
bore_d = 2.5;             // through bore
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

total_h = post_h + flange_t;  // overall height

difference() {
  union() {
    cylinder(h = flange_t, d = flange_d);
    translate([0, 0, flange_t]) cylinder(h = post_h, d = post_d);
  }
  translate([0, 0, -1]) cylinder(h = total_h + 2, d = bore_d);
}
