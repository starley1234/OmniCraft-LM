$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 30, 12, 10 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 15;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 10;                // step 4 length
total = 105;              // overall length
chamfer = 2;              // end chamfer
key_w = 5;                // keyway width
key_d = 2.5;              // keyway depth
key_len = 20;             // keyway length
key_z = 82;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 40], [15, 40], [15, 80], [6, 80], [6, 95], [5, 95], [5, 103], [3, 105], [0, 105]];

difference() {
  rotate_extrude() polygon(profile);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
