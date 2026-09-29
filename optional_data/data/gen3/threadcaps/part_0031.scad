$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 22 mm tall, 45 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 22;              // cap height
top_t = 4;                // closed top thickness
bore_d = 45;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 12;            // threaded height
flutes = 14;              // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 20.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21.5, 0], [21.5, 12], [22, 12], [24, 10.75], [22, 9.5], [24, 8.25], [22, 7], [24, 5.75], [22, 4.5], [24, 3.25], [22, 0], [21.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
