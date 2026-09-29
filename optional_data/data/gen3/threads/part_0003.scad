$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M22.23 x 1.75 thread, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 22.23;          // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 20.12;           // minor diameter
length = 50;              // shank length under the head
plain_len = 25;           // unthreaded length at the head
thread_len = 25;          // threaded length
head_af = 35.6;           // hex across flats
head_h = 14.4;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 14.4, d = 41.107, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[8.062, 0], [8.062, 25], [11.113, 25], [9.762, 24.212], [11.113, 23.25], [9.762, 22.462], [11.113, 21.5], [9.762, 20.712], [11.113, 19.75], [9.762, 18.962], [11.113, 18], [9.762, 17.212], [11.113, 16.25], [9.762, 15.463], [11.113, 14.5], [9.762, 13.713], [11.113, 12.75], [9.762, 11.963], [11.113, 11], [9.762, 10.213], [11.113, 9.25], [9.762, 8.463], [11.113, 7.5], [9.762, 6.713], [11.113, 5.75], [9.762, 4.963], [11.113, 4], [9.762, 3.212], [9.762, 0], [8.062, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 62.9]) cylinder(h = 1.5, d1 = core_d, d2 = 17.124);
}
