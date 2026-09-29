$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 18 mm tall, 39 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 18;              // cap height
top_t = 4;                // closed top thickness
bore_d = 39;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 8;             // threaded height
flutes = 13;              // number of knurl flutes
flute_d = 6;              // flute cutter diameter
flute_depth = 1.2;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 16.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[18.5, 0], [18.5, 8], [19, 8], [20.4, 7.25], [19, 6.5], [20.4, 5.75], [19, 5], [20.4, 4.25], [19, 3.5], [20.4, 2.75], [19, 0], [18.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
