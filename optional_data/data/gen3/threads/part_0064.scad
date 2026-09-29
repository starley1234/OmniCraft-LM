$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M31.75 x 2 thread, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 31.75;          // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 29.35;           // minor diameter
length = 60;              // shank length under the head
plain_len = 33;           // unthreaded length at the head
thread_len = 27;          // threaded length
head_af = 50.8;           // hex across flats
head_h = 20.6;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 20.6, d = 58.659, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[12.675, 0], [12.675, 27], [15.875, 27], [14.375, 26.1], [15.875, 25], [14.375, 24.1], [15.875, 23], [14.375, 22.1], [15.875, 21], [14.375, 20.1], [15.875, 19], [14.375, 18.1], [15.875, 17], [14.375, 16.1], [15.875, 15], [14.375, 14.1], [15.875, 13], [14.375, 12.1], [15.875, 11], [14.375, 10.1], [15.875, 9], [14.375, 8.1], [15.875, 7], [14.375, 6.1], [15.875, 5], [14.375, 4.1], [15.875, 3], [14.375, 2.1], [14.375, 0], [12.675, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 79.1]) cylinder(h = 1.5, d1 = core_d, d2 = 26.35);
}
