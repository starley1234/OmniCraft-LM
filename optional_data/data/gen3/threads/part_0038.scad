$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M25.4 x 1.75 thread, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 23.3;            // minor diameter
length = 50;              // shank length under the head
plain_len = 23;           // unthreaded length at the head
thread_len = 27;          // threaded length
head_af = 40.6;           // hex across flats
head_h = 16.5;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 16.5, d = 46.881, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[9.65, 0], [9.65, 27], [12.7, 27], [11.35, 26.212], [12.7, 25.25], [11.35, 24.462], [12.7, 23.5], [11.35, 22.712], [12.7, 21.75], [11.35, 20.962], [12.7, 20], [11.35, 19.212], [12.7, 18.25], [11.35, 17.462], [12.7, 16.5], [11.35, 15.713], [12.7, 14.75], [11.35, 13.963], [12.7, 13], [11.35, 12.213], [12.7, 11.25], [11.35, 10.463], [12.7, 9.5], [11.35, 8.713], [12.7, 7.75], [11.35, 6.963], [12.7, 6], [11.35, 5.213], [12.7, 4.25], [11.35, 3.462], [12.7, 2.5], [11.35, 1.712], [11.35, 0], [9.65, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 65]) cylinder(h = 1.5, d1 = core_d, d2 = 20.3);
}
