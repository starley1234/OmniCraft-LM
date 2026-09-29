$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 26 mm tall, 40 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 26;              // cap height
top_t = 5;                // closed top thickness
bore_d = 40;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 15;            // threaded height
flange_d = 55;            // flange diameter
flange_t = 4;             // flange thickness

difference() {
  union() {
    cylinder(h = 4, d = flange_d);
    translate([0, 0, 3.5]) cylinder(h = 26.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 27.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[19, 0], [19, 15], [19.5, 15], [21.05, 14.125], [19.5, 13.25], [21.05, 12.375], [19.5, 11.5], [21.05, 10.625], [19.5, 9.75], [21.05, 8.875], [19.5, 8], [21.05, 7.125], [19.5, 6.25], [21.05, 5.375], [19.5, 4.5], [21.05, 3.625], [19.5, 2.75], [21.05, 1.875], [19.5, 0], [19, 0]]);
}
