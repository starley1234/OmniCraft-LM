$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 20, 10 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
total = 90;               // overall length
chamfer = 2;              // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 30], [15, 30], [15, 45], [10, 45], [10, 75], [5, 75], [5, 88], [3, 90], [0, 90]];

difference() {
  rotate_extrude() polygon(profile);
}
