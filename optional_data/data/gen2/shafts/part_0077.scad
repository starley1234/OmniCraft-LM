$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 25, 20, 16, 12 mm, 140 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 20;                // step 4 length
d5 = 12;                  // step 5 diameter
len5 = 40;                // step 5 length
total = 140;              // overall length
chamfer = 1.5;            // end chamfer
key_w = 4;                // keyway width
key_d = 2;                // keyway depth
key_len = 14;             // keyway length
key_z = 123;              // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [15 - chamfer, 0], [15, chamfer], [15, 20], [12.5, 20], [12.5, 50], [10, 50], [10, 80], [8, 80], [8, 100], [6, 100], [6, 138.5], [4.5, 140], [0, 140]];

difference() {
  rotate_extrude() polygon(profile);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
