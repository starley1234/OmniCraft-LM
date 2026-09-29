$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 10, 8 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 10;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 40;                // step 3 length
total = 80;               // overall length
chamfer = 1.5;            // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 10], [5, 10], [5, 40], [4, 40], [4, 78.5], [2.5, 80], [0, 80]];

difference() {
  rotate_extrude() polygon(profile);
}
