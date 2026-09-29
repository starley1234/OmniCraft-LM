$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 30 mm tall, 35 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 30;              // cap height
top_t = 3;                // closed top thickness
bore_d = 35;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 21;            // threaded height
flutes = 14;              // number of knurl flutes
flute_d = 6;              // flute cutter diameter
flute_depth = 1.2;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 29.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[16.5, 0], [16.5, 21], [17, 21], [18.7, 20], [17, 19], [18.7, 18], [17, 17], [18.7, 16], [17, 15], [18.7, 14], [17, 13], [18.7, 12], [17, 11], [18.7, 10], [17, 9], [18.7, 8], [17, 7], [18.7, 6], [17, 5], [18.7, 4], [17, 3], [18.7, 2], [17, 0], [16.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
