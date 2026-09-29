$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 16, 14, 12, 10 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 30;                // step 4 length
d5 = 10;                  // step 5 diameter
len5 = 10;                // step 5 length
total = 105;              // overall length
chamfer = 2.4;            // end chamfer
key_w = 6;                // keyway width
key_d = 3;                // keyway depth
key_len = 19;             // keyway length
key_z = 83;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [15 - chamfer, 0], [15, chamfer], [15, 25], [8, 25], [8, 55], [7, 55], [7, 65], [6, 65], [6, 95], [5, 95], [5, 102.6], [2.6, 105], [0, 105]];

difference() {
  rotate_extrude() polygon(profile);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
