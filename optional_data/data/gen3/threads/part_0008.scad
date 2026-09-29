$fn = 32;

// ----------------------------------------------------------------------
// Threaded stud: M25.4 x 1.75 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 23.3;            // minor diameter
length = 40;              // shank length under the head
thread_len = 40;          // threaded length
head_af = 40.6;           // hex across flats
head_h = 16.5;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 16.5, d = 46.881, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5]) rotate_extrude() polygon([[9.65, 0], [9.65, 40], [12.7, 40], [11.35, 39.212], [12.7, 38.25], [11.35, 37.462], [12.7, 36.5], [11.35, 35.712], [12.7, 34.75], [11.35, 33.962], [12.7, 33], [11.35, 32.212], [12.7, 31.25], [11.35, 30.462], [12.7, 29.5], [11.35, 28.712], [12.7, 27.75], [11.35, 26.962], [12.7, 26], [11.35, 25.212], [12.7, 24.25], [11.35, 23.462], [12.7, 22.5], [11.35, 21.712], [12.7, 20.75], [11.35, 19.962], [12.7, 19], [11.35, 18.212], [12.7, 17.25], [11.35, 16.462], [12.7, 15.5], [11.35, 14.713], [12.7, 13.75], [11.35, 12.963], [12.7, 12], [11.35, 11.213], [12.7, 10.25], [11.35, 9.463], [12.7, 8.5], [11.35, 7.713], [12.7, 6.75], [11.35, 5.963], [12.7, 5], [11.35, 4.213], [12.7, 3.25], [11.35, 2.462], [11.35, 0], [9.65, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 55]) cylinder(h = 1.5, d1 = core_d, d2 = 20.3);
}
