$fn = 32;

// ----------------------------------------------------------------------
// Threaded stud: M7.2 x 2 thread, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 7.2;            // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 4.8;             // minor diameter
length = 70;              // shank length under the head
thread_len = 70;          // threaded length
head_af = 11.5;           // hex across flats
head_h = 4.7;             // head height
chamfer = 0.96;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 4.7, d = 13.279, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5]) rotate_extrude() polygon([[0.5, 0], [0.5, 70], [3.6, 70], [2.1, 69.1], [3.6, 68], [2.1, 67.1], [3.6, 66], [2.1, 65.1], [3.6, 64], [2.1, 63.1], [3.6, 62], [2.1, 61.1], [3.6, 60], [2.1, 59.1], [3.6, 58], [2.1, 57.1], [3.6, 56], [2.1, 55.1], [3.6, 54], [2.1, 53.1], [3.6, 52], [2.1, 51.1], [3.6, 50], [2.1, 49.1], [3.6, 48], [2.1, 47.1], [3.6, 46], [2.1, 45.1], [3.6, 44], [2.1, 43.1], [3.6, 42], [2.1, 41.1], [3.6, 40], [2.1, 39.1], [3.6, 38], [2.1, 37.1], [3.6, 36], [2.1, 35.1], [3.6, 34], [2.1, 33.1], [3.6, 32], [2.1, 31.1], [3.6, 30], [2.1, 29.1], [3.6, 28], [2.1, 27.1], [3.6, 26], [2.1, 25.1], [3.6, 24], [2.1, 23.1], [3.6, 22], [2.1, 21.1], [3.6, 20], [2.1, 19.1], [3.6, 18], [2.1, 17.1], [3.6, 16], [2.1, 15.1], [3.6, 14], [2.1, 13.1], [3.6, 12], [2.1, 11.1], [3.6, 10], [2.1, 9.1], [3.6, 8], [2.1, 7.1], [3.6, 6], [2.1, 5.1], [3.6, 4], [2.1, 3.1], [2.1, 0], [0.5, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 73.74]) cylinder(h = 0.96, d1 = core_d, d2 = 2.88);
}
