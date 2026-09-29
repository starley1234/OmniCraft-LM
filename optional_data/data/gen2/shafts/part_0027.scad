$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 30, 14 mm, 95 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 30;                  // step 3 diameter
len3 = 40;                // step 3 length
d4 = 14;                  // step 4 diameter
len4 = 25;                // step 4 length
total = 95;               // overall length
chamfer = 2;              // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 15], [20, 15], [20, 30], [15, 30], [15, 70], [7, 70], [7, 93], [5, 95], [0, 95]];

difference() {
  rotate_extrude() polygon(profile);
}
