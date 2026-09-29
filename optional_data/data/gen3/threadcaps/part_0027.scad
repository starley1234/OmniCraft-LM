$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 36 mm body, 30 mm tall, 28 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 36;             // cap outside diameter
body_h = 30;              // cap height
top_t = 5;                // closed top thickness
bore_d = 28;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 19;            // threaded height
flutes = 14;              // number of knurl flutes
flute_d = 6;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 27.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[13, 0], [13, 19], [13.5, 19], [15.2, 18], [13.5, 17], [15.2, 16], [13.5, 15], [15.2, 14], [13.5, 13], [15.2, 12], [13.5, 11], [15.2, 10], [13.5, 9], [15.2, 8], [13.5, 7], [15.2, 6], [13.5, 5], [15.2, 4], [13.5, 3], [15.2, 2], [13.5, 0], [13, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
