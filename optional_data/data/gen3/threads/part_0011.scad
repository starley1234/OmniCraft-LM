$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M6.9 x 1.75 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 6.9;            // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 4.8;             // minor diameter
length = 40;              // shank length under the head
plain_len = 18;           // unthreaded length at the head
thread_len = 22;          // threaded length
head_af = 11;             // hex across flats
head_h = 4.5;             // head height
chamfer = 0.96;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 4.5, d = 12.702, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[0.5, 0], [0.5, 22], [3.45, 22], [2.1, 21.212], [3.45, 20.25], [2.1, 19.462], [3.45, 18.5], [2.1, 17.712], [3.45, 16.75], [2.1, 15.963], [3.45, 15], [2.1, 14.213], [3.45, 13.25], [2.1, 12.463], [3.45, 11.5], [2.1, 10.713], [3.45, 9.75], [2.1, 8.963], [3.45, 8], [2.1, 7.213], [3.45, 6.25], [2.1, 5.463], [3.45, 4.5], [2.1, 3.712], [3.45, 2.75], [2.1, 1.962], [2.1, 0], [0.5, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 43.54]) cylinder(h = 0.96, d1 = core_d, d2 = 2.88);
}
