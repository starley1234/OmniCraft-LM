$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M9.53 x 1.5 thread, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 9.53;           // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 7.73;            // minor diameter
length = 60;              // shank length under the head
plain_len = 24.6;         // unthreaded length at the head
thread_len = 35.4;        // threaded length
head_af = 15.2;           // hex across flats
head_h = 6.2;             // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 6.2, d = 17.551, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[1.863, 0], [1.863, 35.4], [4.763, 35.4], [3.563, 34.725], [4.763, 33.9], [3.563, 33.225], [4.763, 32.4], [3.563, 31.725], [4.763, 30.9], [3.563, 30.225], [4.763, 29.4], [3.563, 28.725], [4.763, 27.9], [3.563, 27.225], [4.763, 26.4], [3.563, 25.725], [4.763, 24.9], [3.563, 24.225], [4.763, 23.4], [3.563, 22.725], [4.763, 21.9], [3.563, 21.225], [4.763, 20.4], [3.563, 19.725], [4.763, 18.9], [3.563, 18.225], [4.763, 17.4], [3.563, 16.725], [4.763, 15.9], [3.563, 15.225], [4.763, 14.4], [3.563, 13.725], [4.763, 12.9], [3.563, 12.225], [4.763, 11.4], [3.563, 10.725], [4.763, 9.9], [3.563, 9.225], [4.763, 8.4], [3.563, 7.725], [4.763, 6.9], [3.563, 6.225], [4.763, 5.4], [3.563, 4.725], [4.763, 3.9], [3.563, 3.225], [4.763, 2.4], [3.563, 1.725], [3.563, 0], [1.863, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 64.7]) cylinder(h = 1.5, d1 = core_d, d2 = 4.726);
}
