$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M25.4 x 1.5 thread, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 23.6;            // minor diameter
length = 80;              // shank length under the head
plain_len = 40.8;         // unthreaded length at the head
thread_len = 39.2;        // threaded length
head_af = 40.6;           // hex across flats
head_h = 16.5;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 16.5, d = 46.881, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[9.8, 0], [9.8, 39.2], [12.7, 39.2], [11.5, 38.525], [12.7, 37.7], [11.5, 37.025], [12.7, 36.2], [11.5, 35.525], [12.7, 34.7], [11.5, 34.025], [12.7, 33.2], [11.5, 32.525], [12.7, 31.7], [11.5, 31.025], [12.7, 30.2], [11.5, 29.525], [12.7, 28.7], [11.5, 28.025], [12.7, 27.2], [11.5, 26.525], [12.7, 25.7], [11.5, 25.025], [12.7, 24.2], [11.5, 23.525], [12.7, 22.7], [11.5, 22.025], [12.7, 21.2], [11.5, 20.525], [12.7, 19.7], [11.5, 19.025], [12.7, 18.2], [11.5, 17.525], [12.7, 16.7], [11.5, 16.025], [12.7, 15.2], [11.5, 14.525], [12.7, 13.7], [11.5, 13.025], [12.7, 12.2], [11.5, 11.525], [12.7, 10.7], [11.5, 10.025], [12.7, 9.2], [11.5, 8.525], [12.7, 7.7], [11.5, 7.025], [12.7, 6.2], [11.5, 5.525], [12.7, 4.7], [11.5, 4.025], [12.7, 3.2], [11.5, 2.525], [11.5, 0], [9.8, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 95]) cylinder(h = 1.5, d1 = core_d, d2 = 20.6);
}
