$fn = 32;

// ----------------------------------------------------------------------
// Threaded stud: M31.75 x 2 thread, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 31.75;          // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 29.35;           // minor diameter
length = 50;              // shank length under the head
thread_len = 50;          // threaded length
head_af = 50.8;           // hex across flats
head_h = 20.6;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 20.6, d = 58.659, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5]) rotate_extrude() polygon([[12.675, 0], [12.675, 50], [15.875, 50], [14.375, 49.1], [15.875, 48], [14.375, 47.1], [15.875, 46], [14.375, 45.1], [15.875, 44], [14.375, 43.1], [15.875, 42], [14.375, 41.1], [15.875, 40], [14.375, 39.1], [15.875, 38], [14.375, 37.1], [15.875, 36], [14.375, 35.1], [15.875, 34], [14.375, 33.1], [15.875, 32], [14.375, 31.1], [15.875, 30], [14.375, 29.1], [15.875, 28], [14.375, 27.1], [15.875, 26], [14.375, 25.1], [15.875, 24], [14.375, 23.1], [15.875, 22], [14.375, 21.1], [15.875, 20], [14.375, 19.1], [15.875, 18], [14.375, 17.1], [15.875, 16], [14.375, 15.1], [15.875, 14], [14.375, 13.1], [15.875, 12], [14.375, 11.1], [15.875, 10], [14.375, 9.1], [15.875, 8], [14.375, 7.1], [15.875, 6], [14.375, 5.1], [15.875, 4], [14.375, 3.1], [14.375, 0], [12.675, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 69.1]) cylinder(h = 1.5, d1 = core_d, d2 = 26.35);
}
