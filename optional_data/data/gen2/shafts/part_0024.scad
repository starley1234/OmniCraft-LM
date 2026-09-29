$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 16, 14, 10, 8 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 20;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 20;                // step 5 length
total = 105;              // overall length
chamfer = 1;              // end chamfer
key_w = 8;                // keyway width
key_d = 4;                // keyway depth
key_len = 14;             // keyway length
key_z = 88;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 20], [8, 20], [8, 50], [7, 50], [7, 70], [5, 70], [5, 85], [4, 85], [4, 104], [3, 105], [0, 105]];

difference() {
  rotate_extrude() polygon(profile);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
