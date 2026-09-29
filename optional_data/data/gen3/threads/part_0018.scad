$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M9.53 x 2 thread, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 9.53;           // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 7.12;            // minor diameter
length = 80;              // shank length under the head
plain_len = 43.2;         // unthreaded length at the head
thread_len = 36.8;        // threaded length
head_af = 15.2;           // hex across flats
head_h = 6.2;             // head height
chamfer = 1.42;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 6.2, d = 17.551, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[1.562, 0], [1.562, 36.8], [4.763, 36.8], [3.262, 35.9], [4.763, 34.8], [3.262, 33.9], [4.763, 32.8], [3.262, 31.9], [4.763, 30.8], [3.262, 29.9], [4.763, 28.8], [3.262, 27.9], [4.763, 26.8], [3.262, 25.9], [4.763, 24.8], [3.262, 23.9], [4.763, 22.8], [3.262, 21.9], [4.763, 20.8], [3.262, 19.9], [4.763, 18.8], [3.262, 17.9], [4.763, 16.8], [3.262, 15.9], [4.763, 14.8], [3.262, 13.9], [4.763, 12.8], [3.262, 11.9], [4.763, 10.8], [3.262, 9.9], [4.763, 8.8], [3.262, 7.9], [4.763, 6.8], [3.262, 5.9], [4.763, 4.8], [3.262, 3.9], [4.763, 2.8], [3.262, 1.9], [3.262, 0], [1.562, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 84.78]) cylinder(h = 1.42, d1 = core_d, d2 = 4.284);
}
