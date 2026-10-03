$fn = 32;
// ----------------------------------------------------------------------
// Hex bolt: M19.05 x 1.5 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 19.05;          // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 17.25;           // minor diameter
length = 40;              // shank length under the head
plain_len = 16.8;         // unthreaded length at the head
thread_len = 23.2;        // threaded length
head_af = 30.5;           // hex across flats
head_h = 12.4;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 12.4, d = 35.218, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[6.625, 0], [6.625, 23.2], [9.525, 23.2], [8.325, 22.525], [9.525, 21.7], [8.325, 21.025], [9.525, 20.2], [8.325, 19.525], [9.525, 18.7], [8.325, 18.025], [9.525, 17.2], [8.325, 16.525], [9.525, 15.7], [8.325, 15.025], [9.525, 14.2], [8.325, 13.525], [9.525, 12.7], [8.325, 12.025], [9.525, 11.2], [8.325, 10.525], [9.525, 9.7], [8.325, 9.025], [9.525, 8.2], [8.325, 7.525], [9.525, 6.7], [8.325, 6.025], [9.525, 5.2], [8.325, 4.525], [9.525, 3.7], [8.325, 3.025], [9.525, 2.2], [8.325, 1.525], [8.325, 0], [6.625, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 50.9]) cylinder(h = 1.5, d1 = core_d, d2 = 14.25);
}
