$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 30, 25, 10 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
total = 105;              // overall length
chamfer = 2.5;            // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 20], [15, 20], [15, 60], [12.5, 60], [12.5, 90], [5, 90], [5, 102.5], [2.5, 105], [0, 105]];

difference() {
  rotate_extrude() polygon(profile);
}
