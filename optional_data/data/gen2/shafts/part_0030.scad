$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 12, 10, 8 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 15;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 30;                // step 5 length
total = 80;               // overall length
chamfer = 2;              // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 10], [20, 10], [20, 20], [6, 20], [6, 35], [5, 35], [5, 50], [4, 50], [4, 78], [2, 80], [0, 80]];

difference() {
  rotate_extrude() polygon(profile);
}
