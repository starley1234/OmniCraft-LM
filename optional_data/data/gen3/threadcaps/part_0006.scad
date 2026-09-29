$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 36 mm body, 18 mm tall, 29 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 36;             // cap outside diameter
body_h = 18;              // cap height
top_t = 3;                // closed top thickness
bore_d = 29;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 9;             // threaded height
flutes = 12;              // number of knurl flutes
flute_d = 6;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 17.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[13.5, 0], [13.5, 9], [14, 9], [15.4, 8.25], [14, 7.5], [15.4, 6.75], [14, 6], [15.4, 5.25], [14, 4.5], [15.4, 3.75], [14, 3], [15.4, 2.25], [14, 0], [13.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
