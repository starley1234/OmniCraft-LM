$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M7.94 x 1.5 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 7.94;           // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 6.14;            // minor diameter
length = 40;              // shank length under the head
plain_len = 16.8;         // unthreaded length at the head
thread_len = 23.2;        // threaded length
head_af = 12.7;           // hex across flats
head_h = 5.2;             // head height
chamfer = 1.23;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 5.2, d = 14.665, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[1.069, 0], [1.069, 23.2], [3.969, 23.2], [2.769, 22.525], [3.969, 21.7], [2.769, 21.025], [3.969, 20.2], [2.769, 19.525], [3.969, 18.7], [2.769, 18.025], [3.969, 17.2], [2.769, 16.525], [3.969, 15.7], [2.769, 15.025], [3.969, 14.2], [2.769, 13.525], [3.969, 12.7], [2.769, 12.025], [3.969, 11.2], [2.769, 10.525], [3.969, 9.7], [2.769, 9.025], [3.969, 8.2], [2.769, 7.525], [3.969, 6.7], [2.769, 6.025], [3.969, 5.2], [2.769, 4.525], [3.969, 3.7], [2.769, 3.025], [3.969, 2.2], [2.769, 1.525], [2.769, 0], [1.069, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 43.97]) cylinder(h = 1.23, d1 = core_d, d2 = 3.678);
}
