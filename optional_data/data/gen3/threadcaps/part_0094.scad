$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 30 mm tall, 45 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 30;              // cap height
top_t = 3;                // closed top thickness
bore_d = 45;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 21;            // threaded height
flutes = 11;              // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1;          // flute depth into the rim

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 29.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21.5, 0], [21.5, 21], [22, 21], [23.4, 20.25], [22, 19.5], [23.4, 18.75], [22, 18], [23.4, 17.25], [22, 16.5], [23.4, 15.75], [22, 15], [23.4, 14.25], [22, 13.5], [23.4, 12.75], [22, 12], [23.4, 11.25], [22, 10.5], [23.4, 9.75], [22, 9], [23.4, 8.25], [22, 7.5], [23.4, 6.75], [22, 6], [23.4, 5.25], [22, 4.5], [23.4, 3.75], [22, 3], [23.4, 2.25], [22, 0], [21.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
