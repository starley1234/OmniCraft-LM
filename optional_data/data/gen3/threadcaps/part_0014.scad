$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 26 mm tall, 45 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 26;              // cap height
top_t = 4;                // closed top thickness
bore_d = 45;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 16;            // threaded height
flutes = 8;               // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1;          // flute depth into the rim

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 24.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21.5, 0], [21.5, 16], [22, 16], [24, 14.75], [22, 13.5], [24, 12.25], [22, 11], [24, 9.75], [22, 8.5], [24, 7.25], [22, 6], [24, 4.75], [22, 3.5], [24, 2.25], [22, 0], [21.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
