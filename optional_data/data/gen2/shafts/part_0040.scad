$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 25, 20, 16, 8 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 10;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 10;                // step 5 length
total = 90;               // overall length
chamfer = 2;              // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 15], [12.5, 15], [12.5, 45], [10, 45], [10, 70], [8, 70], [8, 80], [4, 80], [4, 88], [2, 90], [0, 90]];

difference() {
  rotate_extrude() polygon(profile);
}
