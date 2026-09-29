$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 36 mm body, 26 mm tall, 28 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 36;             // cap outside diameter
body_h = 26;              // cap height
top_t = 5;                // closed top thickness
bore_d = 28;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 15;            // threaded height
flutes = 14;              // number of knurl flutes
flute_d = 7;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 23.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[13, 0], [13, 15], [13.5, 15], [15.5, 13.75], [13.5, 12.5], [15.5, 11.25], [13.5, 10], [15.5, 8.75], [13.5, 7.5], [15.5, 6.25], [13.5, 5], [15.5, 3.75], [13.5, 0], [13, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
