$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 14, 12 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 14;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 30;                // step 3 length
total = 90;               // overall length
chamfer = 2;              // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 40], [7, 40], [7, 60], [6, 60], [6, 88], [4, 90], [0, 90]];

difference() {
  rotate_extrude() polygon(profile);
}
