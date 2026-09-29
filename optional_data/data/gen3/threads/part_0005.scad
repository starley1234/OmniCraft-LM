$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M25.4 x 2 thread, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 23;              // minor diameter
length = 70;              // shank length under the head
plain_len = 35.7;         // unthreaded length at the head
thread_len = 34.3;        // threaded length
head_af = 40.6;           // hex across flats
head_h = 16.5;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 16.5, d = 46.881, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[9.5, 0], [9.5, 34.3], [12.7, 34.3], [11.2, 33.4], [12.7, 32.3], [11.2, 31.4], [12.7, 30.3], [11.2, 29.4], [12.7, 28.3], [11.2, 27.4], [12.7, 26.3], [11.2, 25.4], [12.7, 24.3], [11.2, 23.4], [12.7, 22.3], [11.2, 21.4], [12.7, 20.3], [11.2, 19.4], [12.7, 18.3], [11.2, 17.4], [12.7, 16.3], [11.2, 15.4], [12.7, 14.3], [11.2, 13.4], [12.7, 12.3], [11.2, 11.4], [12.7, 10.3], [11.2, 9.4], [12.7, 8.3], [11.2, 7.4], [12.7, 6.3], [11.2, 5.4], [12.7, 4.3], [11.2, 3.4], [11.2, 0], [9.5, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 85]) cylinder(h = 1.5, d1 = core_d, d2 = 20);
}
