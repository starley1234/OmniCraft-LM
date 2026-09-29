$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M31.75 x 1.75 thread, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 31.75;          // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 29.65;           // minor diameter
length = 50;              // shank length under the head
plain_len = 23.5;         // unthreaded length at the head
thread_len = 26.5;        // threaded length
head_af = 50.8;           // hex across flats
head_h = 20.6;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 20.6, d = 58.659, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[12.825, 0], [12.825, 26.5], [15.875, 26.5], [14.525, 25.712], [15.875, 24.75], [14.525, 23.962], [15.875, 23], [14.525, 22.212], [15.875, 21.25], [14.525, 20.462], [15.875, 19.5], [14.525, 18.712], [15.875, 17.75], [14.525, 16.962], [15.875, 16], [14.525, 15.213], [15.875, 14.25], [14.525, 13.463], [15.875, 12.5], [14.525, 11.713], [15.875, 10.75], [14.525, 9.963], [15.875, 9], [14.525, 8.213], [15.875, 7.25], [14.525, 6.463], [15.875, 5.5], [14.525, 4.713], [15.875, 3.75], [14.525, 2.962], [14.525, 0], [12.825, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 69.1]) cylinder(h = 1.5, d1 = core_d, d2 = 26.65);
}
