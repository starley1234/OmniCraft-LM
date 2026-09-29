$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 36 mm body, 30 mm tall, 28 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 36;             // cap outside diameter
body_h = 30;              // cap height
top_t = 4;                // closed top thickness
bore_d = 28;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 20;            // threaded height
flutes = 11;              // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 28.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[13, 0], [13, 20], [13.5, 20], [15.2, 19], [13.5, 18], [15.2, 17], [13.5, 16], [15.2, 15], [13.5, 14], [15.2, 13], [13.5, 12], [15.2, 11], [13.5, 10], [15.2, 9], [13.5, 8], [15.2, 7], [13.5, 6], [15.2, 5], [13.5, 4], [15.2, 3], [13.5, 0], [13, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
