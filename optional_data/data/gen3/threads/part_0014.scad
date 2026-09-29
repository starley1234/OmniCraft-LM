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
plain_len = 31.2;         // unthreaded length at the head
thread_len = 28.8;        // threaded length
head_af = 25.4;           // hex across flats
head_h = 10.3;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 10.3, d = 29.329, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[4.888, 0], [4.888, 28.8], [7.938, 28.8], [6.588, 28.012], [7.938, 27.05], [6.588, 26.262], [7.938, 25.3], [6.588, 24.512], [7.938, 23.55], [6.588, 22.762], [7.938, 21.8], [6.588, 21.012], [7.938, 20.05], [6.588, 19.262], [7.938, 18.3], [6.588, 17.512], [7.938, 16.55], [6.588, 15.763], [7.938, 14.8], [6.588, 14.013], [7.938, 13.05], [6.588, 12.263], [7.938, 11.3], [6.588, 10.513], [7.938, 9.55], [6.588, 8.763], [7.938, 7.8], [6.588, 7.013], [7.938, 6.05], [6.588, 5.263], [7.938, 4.3], [6.588, 3.512], [7.938, 2.55], [6.588, 1.762], [6.588, 0], [4.888, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 68.8]) cylinder(h = 1.5, d1 = core_d, d2 = 10.776);
}
