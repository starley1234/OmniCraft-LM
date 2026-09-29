$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 26 mm tall, 40 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 26;              // cap height
top_t = 4;                // closed top thickness
bore_d = 40;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 16;            // threaded height
flutes = 10;              // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 24.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[19, 0], [19, 16], [19.5, 16], [21.5, 14.75], [19.5, 13.5], [21.5, 12.25], [19.5, 11], [21.5, 9.75], [19.5, 8.5], [21.5, 7.25], [19.5, 6], [21.5, 4.75], [19.5, 3.5], [21.5, 2.25], [19.5, 0], [19, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
