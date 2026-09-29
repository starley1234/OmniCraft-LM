$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 36 mm body, 18 mm tall, 29 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 36;             // cap outside diameter
body_h = 18;              // cap height
top_t = 3;                // closed top thickness
bore_d = 29;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 9;             // threaded height
flange_d = 46;            // flange diameter
flange_t = 5;             // flange thickness

difference() {
  union() {
    cylinder(h = 5, d = flange_d);
    translate([0, 0, 4.5]) cylinder(h = 18.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 22.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[13.5, 0], [13.5, 9], [14, 9], [15.55, 8.125], [14, 7.25], [15.55, 6.375], [14, 5.5], [15.55, 4.625], [14, 3.75], [15.55, 2.875], [14, 0], [13.5, 0]]);
}
