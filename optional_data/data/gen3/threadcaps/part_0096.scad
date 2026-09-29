$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 22 mm tall, 32 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 22;              // cap height
top_t = 5;                // closed top thickness
bore_d = 32;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 11;            // threaded height
flutes = 9;               // number of knurl flutes
flute_d = 7;              // flute cutter diameter
flute_depth = 1;          // flute depth into the rim

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 19.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[15, 0], [15, 11], [15.5, 11], [17.2, 10], [15.5, 9], [17.2, 8], [15.5, 7], [17.2, 6], [15.5, 5], [17.2, 4], [15.5, 3], [17.2, 2], [15.5, 0], [15, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
