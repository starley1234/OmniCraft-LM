$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 26 mm tall, 34 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 26;              // cap height
top_t = 5;                // closed top thickness
bore_d = 34;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 15;            // threaded height
flange_d = 46;            // flange diameter
flange_t = 4;             // flange thickness

difference() {
  union() {
    cylinder(h = 4, d = flange_d);
    translate([0, 0, 3.5]) cylinder(h = 26.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 27.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[16, 0], [16, 15], [16.5, 15], [18.05, 14.125], [16.5, 13.25], [18.05, 12.375], [16.5, 11.5], [18.05, 10.625], [16.5, 9.75], [18.05, 8.875], [16.5, 8], [18.05, 7.125], [16.5, 6.25], [18.05, 5.375], [16.5, 4.5], [18.05, 3.625], [16.5, 2.75], [18.05, 1.875], [16.5, 0], [16, 0]]);
}
