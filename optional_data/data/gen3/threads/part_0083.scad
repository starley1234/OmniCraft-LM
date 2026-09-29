$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M22.23 x 2 thread, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 22.23;          // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 19.83;           // minor diameter
length = 50;              // shank length under the head
plain_len = 22.5;         // unthreaded length at the head
thread_len = 27.5;        // threaded length
head_af = 35.6;           // hex across flats
head_h = 14.4;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 14.4, d = 41.107, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[7.913, 0], [7.913, 27.5], [11.113, 27.5], [9.613, 26.6], [11.113, 25.5], [9.613, 24.6], [11.113, 23.5], [9.613, 22.6], [11.113, 21.5], [9.613, 20.6], [11.113, 19.5], [9.613, 18.6], [11.113, 17.5], [9.613, 16.6], [11.113, 15.5], [9.613, 14.6], [11.113, 13.5], [9.613, 12.6], [11.113, 11.5], [9.613, 10.6], [11.113, 9.5], [9.613, 8.6], [11.113, 7.5], [9.613, 6.6], [11.113, 5.5], [9.613, 4.6], [11.113, 3.5], [9.613, 2.6], [9.613, 0], [7.913, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 62.9]) cylinder(h = 1.5, d1 = core_d, d2 = 16.826);
}
