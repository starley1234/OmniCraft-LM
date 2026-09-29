$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 26 mm tall, 24 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 26;              // cap height
top_t = 3;                // closed top thickness
bore_d = 24;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 17;            // threaded height
flutes = 9;               // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 25.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[11, 0], [11, 17], [11.5, 17], [12.9, 16.25], [11.5, 15.5], [12.9, 14.75], [11.5, 14], [12.9, 13.25], [11.5, 12.5], [12.9, 11.75], [11.5, 11], [12.9, 10.25], [11.5, 9.5], [12.9, 8.75], [11.5, 8], [12.9, 7.25], [11.5, 6.5], [12.9, 5.75], [11.5, 5], [12.9, 4.25], [11.5, 3.5], [12.9, 2.75], [11.5, 0], [11, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
