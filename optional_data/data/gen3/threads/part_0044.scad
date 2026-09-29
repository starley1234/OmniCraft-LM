$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M7.94 x 2 thread, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 7.94;           // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 5.54;            // minor diameter
length = 60;              // shank length under the head
plain_len = 24;           // unthreaded length at the head
thread_len = 36;          // threaded length
head_af = 12.7;           // hex across flats
head_h = 5.2;             // head height
chamfer = 1.11;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 5.2, d = 14.665, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[0.769, 0], [0.769, 36], [3.969, 36], [2.469, 35.1], [3.969, 34], [2.469, 33.1], [3.969, 32], [2.469, 31.1], [3.969, 30], [2.469, 29.1], [3.969, 28], [2.469, 27.1], [3.969, 26], [2.469, 25.1], [3.969, 24], [2.469, 23.1], [3.969, 22], [2.469, 21.1], [3.969, 20], [2.469, 19.1], [3.969, 18], [2.469, 17.1], [3.969, 16], [2.469, 15.1], [3.969, 14], [2.469, 13.1], [3.969, 12], [2.469, 11.1], [3.969, 10], [2.469, 9.1], [3.969, 8], [2.469, 7.1], [3.969, 6], [2.469, 5.1], [3.969, 4], [2.469, 3.1], [2.469, 0], [0.769, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 64.09]) cylinder(h = 1.11, d1 = core_d, d2 = 3.318);
}
