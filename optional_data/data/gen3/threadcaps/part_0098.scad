$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 36 mm body, 18 mm tall, 29 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 36;             // cap outside diameter
body_h = 18;              // cap height
top_t = 5;                // closed top thickness
bore_d = 29;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 7;             // threaded height
flutes = 12;              // number of knurl flutes
flute_d = 7;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 15.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[13.5, 0], [13.5, 7], [14, 7], [15.7, 6], [14, 5], [15.7, 4], [14, 3], [15.7, 2], [14, 0], [13.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
