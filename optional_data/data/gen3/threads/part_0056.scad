$fn = 32;

// ----------------------------------------------------------------------
// Threaded stud: M22.23 x 2 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 22.23;          // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 19.83;           // minor diameter
length = 40;              // shank length under the head
thread_len = 40;          // threaded length
head_af = 35.6;           // hex across flats
head_h = 14.4;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 14.4, d = 41.107, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5]) rotate_extrude() polygon([[7.913, 0], [7.913, 40], [11.113, 40], [9.613, 39.1], [11.113, 38], [9.613, 37.1], [11.113, 36], [9.613, 35.1], [11.113, 34], [9.613, 33.1], [11.113, 32], [9.613, 31.1], [11.113, 30], [9.613, 29.1], [11.113, 28], [9.613, 27.1], [11.113, 26], [9.613, 25.1], [11.113, 24], [9.613, 23.1], [11.113, 22], [9.613, 21.1], [11.113, 20], [9.613, 19.1], [11.113, 18], [9.613, 17.1], [11.113, 16], [9.613, 15.1], [11.113, 14], [9.613, 13.1], [11.113, 12], [9.613, 11.1], [11.113, 10], [9.613, 9.1], [11.113, 8], [9.613, 7.1], [11.113, 6], [9.613, 5.1], [11.113, 4], [9.613, 3.1], [9.613, 0], [7.913, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 52.9]) cylinder(h = 1.5, d1 = core_d, d2 = 16.826);
}
