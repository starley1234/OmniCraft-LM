$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 12, 10 mm, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 12;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 15;                // step 3 length
total = 60;               // overall length
chamfer = 1.5;            // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 30], [6, 30], [6, 45], [5, 45], [5, 58.5], [3.5, 60], [0, 60]];

difference() {
  rotate_extrude() polygon(profile);
}
