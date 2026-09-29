$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M12.7 x 1.5 thread, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 12.7;           // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 10.9;            // minor diameter
length = 50;              // shank length under the head
plain_len = 21;           // unthreaded length at the head
thread_len = 29;          // threaded length
head_af = 20.3;           // hex across flats
head_h = 8.3;             // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 8.3, d = 23.44, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[3.45, 0], [3.45, 29], [6.35, 29], [5.15, 28.325], [6.35, 27.5], [5.15, 26.825], [6.35, 26], [5.15, 25.325], [6.35, 24.5], [5.15, 23.825], [6.35, 23], [5.15, 22.325], [6.35, 21.5], [5.15, 20.825], [6.35, 20], [5.15, 19.325], [6.35, 18.5], [5.15, 17.825], [6.35, 17], [5.15, 16.325], [6.35, 15.5], [5.15, 14.825], [6.35, 14], [5.15, 13.325], [6.35, 12.5], [5.15, 11.825], [6.35, 11], [5.15, 10.325], [6.35, 9.5], [5.15, 8.825], [6.35, 8], [5.15, 7.325], [6.35, 6.5], [5.15, 5.825], [6.35, 5], [5.15, 4.325], [6.35, 3.5], [5.15, 2.825], [5.15, 0], [3.45, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 56.8]) cylinder(h = 1.5, d1 = core_d, d2 = 7.9);
}
