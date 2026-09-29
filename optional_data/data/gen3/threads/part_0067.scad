$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M15.88 x 2 thread, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 15.88;          // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 13.47;           // minor diameter
length = 80;              // shank length under the head
plain_len = 35.2;         // unthreaded length at the head
thread_len = 44.8;        // threaded length
head_af = 25.4;           // hex across flats
head_h = 10.3;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 10.3, d = 29.329, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[4.737, 0], [4.737, 44.8], [7.938, 44.8], [6.437, 43.9], [7.938, 42.8], [6.437, 41.9], [7.938, 40.8], [6.437, 39.9], [7.938, 38.8], [6.437, 37.9], [7.938, 36.8], [6.437, 35.9], [7.938, 34.8], [6.437, 33.9], [7.938, 32.8], [6.437, 31.9], [7.938, 30.8], [6.437, 29.9], [7.938, 28.8], [6.437, 27.9], [7.938, 26.8], [6.437, 25.9], [7.938, 24.8], [6.437, 23.9], [7.938, 22.8], [6.437, 21.9], [7.938, 20.8], [6.437, 19.9], [7.938, 18.8], [6.437, 17.9], [7.938, 16.8], [6.437, 15.9], [7.938, 14.8], [6.437, 13.9], [7.938, 12.8], [6.437, 11.9], [7.938, 10.8], [6.437, 9.9], [7.938, 8.8], [6.437, 7.9], [7.938, 6.8], [6.437, 5.9], [7.938, 4.8], [6.437, 3.9], [7.938, 2.8], [6.437, 1.9], [6.437, 0], [4.737, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 88.8]) cylinder(h = 1.5, d1 = core_d, d2 = 10.474);
}
