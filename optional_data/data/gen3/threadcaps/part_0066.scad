$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 30 mm tall, 37 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 30;              // cap height
top_t = 5;                // closed top thickness
bore_d = 37;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 19;            // threaded height

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 27.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[17.5, 0], [17.5, 19], [18, 19], [19.55, 18.125], [18, 17.25], [19.55, 16.375], [18, 15.5], [19.55, 14.625], [18, 13.75], [19.55, 12.875], [18, 12], [19.55, 11.125], [18, 10.25], [19.55, 9.375], [18, 8.5], [19.55, 7.625], [18, 6.75], [19.55, 5.875], [18, 5], [19.55, 4.125], [18, 3.25], [19.55, 2.375], [18, 0], [17.5, 0]]);
}
