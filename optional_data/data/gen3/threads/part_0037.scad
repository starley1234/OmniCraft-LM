$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M25.4 x 1.75 thread, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 23.3;            // minor diameter
length = 80;              // shank length under the head
plain_len = 38.4;         // unthreaded length at the head
thread_len = 41.6;        // threaded length
head_af = 40.6;           // hex across flats
head_h = 16.5;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 16.5, d = 46.881, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[9.65, 0], [9.65, 41.6], [12.7, 41.6], [11.35, 40.812], [12.7, 39.85], [11.35, 39.062], [12.7, 38.1], [11.35, 37.312], [12.7, 36.35], [11.35, 35.562], [12.7, 34.6], [11.35, 33.812], [12.7, 32.85], [11.35, 32.062], [12.7, 31.1], [11.35, 30.312], [12.7, 29.35], [11.35, 28.562], [12.7, 27.6], [11.35, 26.812], [12.7, 25.85], [11.35, 25.062], [12.7, 24.1], [11.35, 23.312], [12.7, 22.35], [11.35, 21.562], [12.7, 20.6], [11.35, 19.812], [12.7, 18.85], [11.35, 18.062], [12.7, 17.1], [11.35, 16.312], [12.7, 15.35], [11.35, 14.562], [12.7, 13.6], [11.35, 12.812], [12.7, 11.85], [11.35, 11.062], [12.7, 10.1], [11.35, 9.312], [12.7, 8.35], [11.35, 7.562], [12.7, 6.6], [11.35, 5.812], [12.7, 4.85], [11.35, 4.062], [12.7, 3.1], [11.35, 2.312], [11.35, 0], [9.65, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 95]) cylinder(h = 1.5, d1 = core_d, d2 = 20.3);
}
