$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M6.9 x 1.75 thread, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 6.9;            // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 4.8;             // minor diameter
length = 70;              // shank length under the head
plain_len = 34.3;         // unthreaded length at the head
thread_len = 35.7;        // threaded length
head_af = 11;             // hex across flats
head_h = 4.5;             // head height
chamfer = 0.96;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 4.5, d = 12.702, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[0.5, 0], [0.5, 35.7], [3.45, 35.7], [2.1, 34.913], [3.45, 33.95], [2.1, 33.163], [3.45, 32.2], [2.1, 31.413], [3.45, 30.45], [2.1, 29.662], [3.45, 28.7], [2.1, 27.912], [3.45, 26.95], [2.1, 26.162], [3.45, 25.2], [2.1, 24.412], [3.45, 23.45], [2.1, 22.662], [3.45, 21.7], [2.1, 20.912], [3.45, 19.95], [2.1, 19.162], [3.45, 18.2], [2.1, 17.412], [3.45, 16.45], [2.1, 15.662], [3.45, 14.7], [2.1, 13.912], [3.45, 12.95], [2.1, 12.162], [3.45, 11.2], [2.1, 10.412], [3.45, 9.45], [2.1, 8.662], [3.45, 7.7], [2.1, 6.913], [3.45, 5.95], [2.1, 5.163], [3.45, 4.2], [2.1, 3.413], [3.45, 2.45], [2.1, 1.663], [2.1, 0], [0.5, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 73.54]) cylinder(h = 0.96, d1 = core_d, d2 = 2.88);
}
