$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M7.94 x 1.5 thread, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 7.94;           // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 6.14;            // minor diameter
length = 60;              // shank length under the head
plain_len = 33;           // unthreaded length at the head
thread_len = 27;          // threaded length
head_af = 12.7;           // hex across flats
head_h = 5.2;             // head height
chamfer = 1.23;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 5.2, d = 14.665, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[1.069, 0], [1.069, 27], [3.969, 27], [2.769, 26.325], [3.969, 25.5], [2.769, 24.825], [3.969, 24], [2.769, 23.325], [3.969, 22.5], [2.769, 21.825], [3.969, 21], [2.769, 20.325], [3.969, 19.5], [2.769, 18.825], [3.969, 18], [2.769, 17.325], [3.969, 16.5], [2.769, 15.825], [3.969, 15], [2.769, 14.325], [3.969, 13.5], [2.769, 12.825], [3.969, 12], [2.769, 11.325], [3.969, 10.5], [2.769, 9.825], [3.969, 9], [2.769, 8.325], [3.969, 7.5], [2.769, 6.825], [3.969, 6], [2.769, 5.325], [3.969, 4.5], [2.769, 3.825], [3.969, 3], [2.769, 2.325], [2.769, 0], [1.069, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 63.97]) cylinder(h = 1.23, d1 = core_d, d2 = 3.678);
}
