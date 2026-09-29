$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M7.94 x 1.75 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 7.94;           // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 5.84;            // minor diameter
length = 40;              // shank length under the head
plain_len = 20.8;         // unthreaded length at the head
thread_len = 19.2;        // threaded length
head_af = 12.7;           // hex across flats
head_h = 5.2;             // head height
chamfer = 1.17;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 5.2, d = 14.665, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[0.919, 0], [0.919, 19.2], [3.969, 19.2], [2.619, 18.412], [3.969, 17.45], [2.619, 16.662], [3.969, 15.7], [2.619, 14.912], [3.969, 13.95], [2.619, 13.162], [3.969, 12.2], [2.619, 11.412], [3.969, 10.45], [2.619, 9.662], [3.969, 8.7], [2.619, 7.912], [3.969, 6.95], [2.619, 6.163], [3.969, 5.2], [2.619, 4.413], [3.969, 3.45], [2.619, 2.663], [2.619, 0], [0.919, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 44.03]) cylinder(h = 1.17, d1 = core_d, d2 = 3.498);
}
