$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M15.88 x 1.5 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 15.88;          // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 14.07;           // minor diameter
length = 40;              // shank length under the head
plain_len = 19.2;         // unthreaded length at the head
thread_len = 20.8;        // threaded length
head_af = 25.4;           // hex across flats
head_h = 10.3;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 10.3, d = 29.329, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[5.037, 0], [5.037, 20.8], [7.938, 20.8], [6.737, 20.125], [7.938, 19.3], [6.737, 18.625], [7.938, 17.8], [6.737, 17.125], [7.938, 16.3], [6.737, 15.625], [7.938, 14.8], [6.737, 14.125], [7.938, 13.3], [6.737, 12.625], [7.938, 11.8], [6.737, 11.125], [7.938, 10.3], [6.737, 9.625], [7.938, 8.8], [6.737, 8.125], [7.938, 7.3], [6.737, 6.625], [7.938, 5.8], [6.737, 5.125], [7.938, 4.3], [6.737, 3.625], [7.938, 2.8], [6.737, 2.125], [6.737, 0], [5.037, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 48.8]) cylinder(h = 1.5, d1 = core_d, d2 = 11.074);
}
