$fn = 32;

// ----------------------------------------------------------------------
// Threaded stud: M9.53 x 2 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 9.53;           // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 7.12;            // minor diameter
length = 40;              // shank length under the head
thread_len = 40;          // threaded length
head_af = 15.2;           // hex across flats
head_h = 6.2;             // head height
chamfer = 1.42;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 6.2, d = 17.551, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5]) rotate_extrude() polygon([[1.562, 0], [1.562, 40], [4.763, 40], [3.262, 39.1], [4.763, 38], [3.262, 37.1], [4.763, 36], [3.262, 35.1], [4.763, 34], [3.262, 33.1], [4.763, 32], [3.262, 31.1], [4.763, 30], [3.262, 29.1], [4.763, 28], [3.262, 27.1], [4.763, 26], [3.262, 25.1], [4.763, 24], [3.262, 23.1], [4.763, 22], [3.262, 21.1], [4.763, 20], [3.262, 19.1], [4.763, 18], [3.262, 17.1], [4.763, 16], [3.262, 15.1], [4.763, 14], [3.262, 13.1], [4.763, 12], [3.262, 11.1], [4.763, 10], [3.262, 9.1], [4.763, 8], [3.262, 7.1], [4.763, 6], [3.262, 5.1], [4.763, 4], [3.262, 3.1], [3.262, 0], [1.562, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 44.78]) cylinder(h = 1.42, d1 = core_d, d2 = 4.284);
}
