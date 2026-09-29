$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M9.53 x 1.75 thread, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 9.53;           // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 7.43;            // minor diameter
length = 80;              // shank length under the head
plain_len = 38.4;         // unthreaded length at the head
thread_len = 41.6;        // threaded length
head_af = 15.2;           // hex across flats
head_h = 6.2;             // head height
chamfer = 1.49;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 6.2, d = 17.551, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[1.713, 0], [1.713, 41.6], [4.763, 41.6], [3.413, 40.812], [4.763, 39.85], [3.413, 39.062], [4.763, 38.1], [3.413, 37.312], [4.763, 36.35], [3.413, 35.562], [4.763, 34.6], [3.413, 33.812], [4.763, 32.85], [3.413, 32.062], [4.763, 31.1], [3.413, 30.312], [4.763, 29.35], [3.413, 28.562], [4.763, 27.6], [3.413, 26.812], [4.763, 25.85], [3.413, 25.062], [4.763, 24.1], [3.413, 23.312], [4.763, 22.35], [3.413, 21.562], [4.763, 20.6], [3.413, 19.812], [4.763, 18.85], [3.413, 18.062], [4.763, 17.1], [3.413, 16.312], [4.763, 15.35], [3.413, 14.562], [4.763, 13.6], [3.413, 12.812], [4.763, 11.85], [3.413, 11.062], [4.763, 10.1], [3.413, 9.312], [4.763, 8.35], [3.413, 7.562], [4.763, 6.6], [3.413, 5.812], [4.763, 4.85], [3.413, 4.062], [4.763, 3.1], [3.413, 2.312], [3.413, 0], [1.713, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 84.71]) cylinder(h = 1.49, d1 = core_d, d2 = 4.446);
}
