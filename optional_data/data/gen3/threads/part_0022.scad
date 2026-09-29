$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M25.4 x 2 thread, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 23;              // minor diameter
length = 80;              // shank length under the head
plain_len = 39.2;         // unthreaded length at the head
thread_len = 40.8;        // threaded length
head_af = 40.6;           // hex across flats
head_h = 16.5;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 16.5, d = 46.881, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[9.5, 0], [9.5, 40.8], [12.7, 40.8], [11.2, 39.9], [12.7, 38.8], [11.2, 37.9], [12.7, 36.8], [11.2, 35.9], [12.7, 34.8], [11.2, 33.9], [12.7, 32.8], [11.2, 31.9], [12.7, 30.8], [11.2, 29.9], [12.7, 28.8], [11.2, 27.9], [12.7, 26.8], [11.2, 25.9], [12.7, 24.8], [11.2, 23.9], [12.7, 22.8], [11.2, 21.9], [12.7, 20.8], [11.2, 19.9], [12.7, 18.8], [11.2, 17.9], [12.7, 16.8], [11.2, 15.9], [12.7, 14.8], [11.2, 13.9], [12.7, 12.8], [11.2, 11.9], [12.7, 10.8], [11.2, 9.9], [12.7, 8.8], [11.2, 7.9], [12.7, 6.8], [11.2, 5.9], [12.7, 4.8], [11.2, 3.9], [12.7, 2.8], [11.2, 1.9], [11.2, 0], [9.5, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 95]) cylinder(h = 1.5, d1 = core_d, d2 = 20);
}
