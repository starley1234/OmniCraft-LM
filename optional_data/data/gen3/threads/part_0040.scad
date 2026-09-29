$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M7.2 x 2 thread, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 7.2;            // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 4.8;             // minor diameter
length = 80;              // shank length under the head
plain_len = 41.6;         // unthreaded length at the head
thread_len = 38.4;        // threaded length
head_af = 11.5;           // hex across flats
head_h = 4.7;             // head height
chamfer = 0.96;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 4.7, d = 13.279, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[0.5, 0], [0.5, 38.4], [3.6, 38.4], [2.1, 37.5], [3.6, 36.4], [2.1, 35.5], [3.6, 34.4], [2.1, 33.5], [3.6, 32.4], [2.1, 31.5], [3.6, 30.4], [2.1, 29.5], [3.6, 28.4], [2.1, 27.5], [3.6, 26.4], [2.1, 25.5], [3.6, 24.4], [2.1, 23.5], [3.6, 22.4], [2.1, 21.5], [3.6, 20.4], [2.1, 19.5], [3.6, 18.4], [2.1, 17.5], [3.6, 16.4], [2.1, 15.5], [3.6, 14.4], [2.1, 13.5], [3.6, 12.4], [2.1, 11.5], [3.6, 10.4], [2.1, 9.5], [3.6, 8.4], [2.1, 7.5], [3.6, 6.4], [2.1, 5.5], [3.6, 4.4], [2.1, 3.5], [2.1, 0], [0.5, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 83.74]) cylinder(h = 0.96, d1 = core_d, d2 = 2.88);
}
