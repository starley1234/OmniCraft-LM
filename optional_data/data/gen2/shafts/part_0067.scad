$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 20, 12, 10 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 30;                // step 4 length
total = 105;              // overall length
chamfer = 1.5;            // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 20], [10, 20], [10, 45], [6, 45], [6, 75], [5, 75], [5, 103.5], [3.5, 105], [0, 105]];

difference() {
  rotate_extrude() polygon(profile);
}
