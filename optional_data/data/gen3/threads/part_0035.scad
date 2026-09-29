$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M22.23 x 1.75 thread, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 22.23;          // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 20.12;           // minor diameter
length = 60;              // shank length under the head
plain_len = 24;           // unthreaded length at the head
thread_len = 36;          // threaded length
head_af = 35.6;           // hex across flats
head_h = 14.4;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 14.4, d = 41.107, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[8.062, 0], [8.062, 36], [11.113, 36], [9.762, 35.212], [11.113, 34.25], [9.762, 33.462], [11.113, 32.5], [9.762, 31.712], [11.113, 30.75], [9.762, 29.962], [11.113, 29], [9.762, 28.212], [11.113, 27.25], [9.762, 26.462], [11.113, 25.5], [9.762, 24.712], [11.113, 23.75], [9.762, 22.962], [11.113, 22], [9.762, 21.212], [11.113, 20.25], [9.762, 19.462], [11.113, 18.5], [9.762, 17.712], [11.113, 16.75], [9.762, 15.963], [11.113, 15], [9.762, 14.213], [11.113, 13.25], [9.762, 12.463], [11.113, 11.5], [9.762, 10.713], [11.113, 9.75], [9.762, 8.963], [11.113, 8], [9.762, 7.213], [11.113, 6.25], [9.762, 5.463], [11.113, 4.5], [9.762, 3.712], [11.113, 2.75], [9.762, 1.962], [9.762, 0], [8.062, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 72.9]) cylinder(h = 1.5, d1 = core_d, d2 = 17.124);
}
