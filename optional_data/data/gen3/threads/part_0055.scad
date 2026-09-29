$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M15.88 x 2 thread, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 15.88;          // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 13.47;           // minor diameter
length = 70;              // shank length under the head
plain_len = 28.7;         // unthreaded length at the head
thread_len = 41.3;        // threaded length
head_af = 25.4;           // hex across flats
head_h = 10.3;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 10.3, d = 29.329, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[4.737, 0], [4.737, 41.3], [7.938, 41.3], [6.437, 40.4], [7.938, 39.3], [6.437, 38.4], [7.938, 37.3], [6.437, 36.4], [7.938, 35.3], [6.437, 34.4], [7.938, 33.3], [6.437, 32.4], [7.938, 31.3], [6.437, 30.4], [7.938, 29.3], [6.437, 28.4], [7.938, 27.3], [6.437, 26.4], [7.938, 25.3], [6.437, 24.4], [7.938, 23.3], [6.437, 22.4], [7.938, 21.3], [6.437, 20.4], [7.938, 19.3], [6.437, 18.4], [7.938, 17.3], [6.437, 16.4], [7.938, 15.3], [6.437, 14.4], [7.938, 13.3], [6.437, 12.4], [7.938, 11.3], [6.437, 10.4], [7.938, 9.3], [6.437, 8.4], [7.938, 7.3], [6.437, 6.4], [7.938, 5.3], [6.437, 4.4], [7.938, 3.3], [6.437, 2.4], [6.437, 0], [4.737, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 78.8]) cylinder(h = 1.5, d1 = core_d, d2 = 10.474);
}
