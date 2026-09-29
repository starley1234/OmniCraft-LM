$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 16, 12, 8 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 15;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 15;                // step 4 length
total = 90;               // overall length
chamfer = 2;              // end chamfer
key_w = 6;                // keyway width
key_d = 3;                // keyway depth
key_len = 14;             // keyway length
key_z = 73;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 20], [8, 20], [8, 60], [6, 60], [6, 75], [4, 75], [4, 88], [2, 90], [0, 90]];

difference() {
  rotate_extrude() polygon(profile);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
