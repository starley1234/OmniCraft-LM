$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 14, 8 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 30;                // step 4 length
total = 80;               // overall length
chamfer = 2.5;            // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 10], [15, 10], [15, 20], [7, 20], [7, 50], [4, 50], [4, 77.5], [1.5, 80], [0, 80]];

difference() {
  rotate_extrude() polygon(profile);
}
