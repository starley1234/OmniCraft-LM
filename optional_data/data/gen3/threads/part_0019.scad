$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M15.88 x 1.75 thread, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 15.88;          // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 13.78;           // minor diameter
length = 60;              // shank length under the head
plain_len = 31.8;         // unthreaded length at the head
thread_len = 28.2;        // threaded length
head_af = 25.4;           // hex across flats
head_h = 10.3;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 10.3, d = 29.329, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[4.888, 0], [4.888, 28.2], [7.938, 28.2], [6.588, 27.412], [7.938, 26.45], [6.588, 25.662], [7.938, 24.7], [6.588, 23.912], [7.938, 22.95], [6.588, 22.162], [7.938, 21.2], [6.588, 20.412], [7.938, 19.45], [6.588, 18.662], [7.938, 17.7], [6.588, 16.912], [7.938, 15.95], [6.588, 15.162], [7.938, 14.2], [6.588, 13.412], [7.938, 12.45], [6.588, 11.662], [7.938, 10.7], [6.588, 9.912], [7.938, 8.95], [6.588, 8.162], [7.938, 7.2], [6.588, 6.413], [7.938, 5.45], [6.588, 4.663], [7.938, 3.7], [6.588, 2.913], [6.588, 0], [4.888, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 68.8]) cylinder(h = 1.5, d1 = core_d, d2 = 10.776);
}
