$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 26 mm tall, 25 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 26;              // cap height
top_t = 3;                // closed top thickness
bore_d = 25;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 17;            // threaded height
flutes = 12;              // number of knurl flutes
flute_d = 6;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 25.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[11.5, 0], [11.5, 17], [12, 17], [13.7, 16], [12, 15], [13.7, 14], [12, 13], [13.7, 12], [12, 11], [13.7, 10], [12, 9], [13.7, 8], [12, 7], [13.7, 6], [12, 5], [13.7, 4], [12, 3], [13.7, 2], [12, 0], [11.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
