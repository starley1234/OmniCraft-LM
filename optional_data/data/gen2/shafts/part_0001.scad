$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 30, 25, 10 mm, 55 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 15;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
total = 55;               // overall length
chamfer = 2.5;            // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 15], [15, 15], [15, 25], [12.5, 25], [12.5, 40], [5, 40], [5, 52.5], [2.5, 55], [0, 55]];

difference() {
  rotate_extrude() polygon(profile);
}
