$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 26 mm tall, 32 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 26;              // cap height
top_t = 4;                // closed top thickness
bore_d = 32;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 16;            // threaded height
flange_d = 46;            // flange diameter
flange_t = 5;             // flange thickness

difference() {
  union() {
    cylinder(h = 5, d = flange_d);
    translate([0, 0, 4.5]) cylinder(h = 26.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 29.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[15, 0], [15, 16], [15.5, 16], [17.2, 15], [15.5, 14], [17.2, 13], [15.5, 12], [17.2, 11], [15.5, 10], [17.2, 9], [15.5, 8], [17.2, 7], [15.5, 6], [17.2, 5], [15.5, 4], [17.2, 3], [15.5, 0], [15, 0]]);
}
