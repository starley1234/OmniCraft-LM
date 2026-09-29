$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 36 mm body, 18 mm tall, 29 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 36;             // cap outside diameter
body_h = 18;              // cap height
top_t = 4;                // closed top thickness
bore_d = 29;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 8;             // threaded height
flange_d = 46;            // flange diameter
flange_t = 4;             // flange thickness

difference() {
  union() {
    cylinder(h = 4, d = flange_d);
    translate([0, 0, 3.5]) cylinder(h = 18.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 20.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[13.5, 0], [13.5, 8], [14, 8], [15.55, 7.125], [14, 6.25], [15.55, 5.375], [14, 4.5], [15.55, 3.625], [14, 2.75], [15.55, 1.875], [14, 0], [13.5, 0]]);
}
