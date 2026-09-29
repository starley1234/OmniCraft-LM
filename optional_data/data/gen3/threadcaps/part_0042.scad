$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 36 mm body, 22 mm tall, 30 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 36;             // cap outside diameter
body_h = 22;              // cap height
top_t = 4;                // closed top thickness
bore_d = 30;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 12;            // threaded height
flutes = 11;              // number of knurl flutes
flute_d = 7;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 20.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[14, 0], [14, 12], [14.5, 12], [16.05, 11.125], [14.5, 10.25], [16.05, 9.375], [14.5, 8.5], [16.05, 7.625], [14.5, 6.75], [16.05, 5.875], [14.5, 5], [16.05, 4.125], [14.5, 3.25], [16.05, 2.375], [14.5, 0], [14, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
