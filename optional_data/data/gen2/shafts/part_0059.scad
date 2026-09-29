$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 25, 16 mm, 55 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 20;                // step 3 length
total = 55;               // overall length
chamfer = 2;              // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [15 - chamfer, 0], [15, chamfer], [15, 25], [12.5, 25], [12.5, 35], [8, 35], [8, 53], [6, 55], [0, 55]];

difference() {
  rotate_extrude() polygon(profile);
}
