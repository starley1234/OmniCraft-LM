$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 20, 16, 14 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 14;                  // step 4 diameter
len4 = 20;                // step 4 length
total = 90;               // overall length
chamfer = 2.5;            // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 30], [10, 30], [10, 45], [8, 45], [8, 70], [7, 70], [7, 87.5], [4.5, 90], [0, 90]];

difference() {
  rotate_extrude() polygon(profile);
}
