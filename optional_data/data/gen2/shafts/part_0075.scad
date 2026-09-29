$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 20, 12 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
total = 80;               // overall length
chamfer = 1;              // end chamfer

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 30], [10, 30], [10, 55], [6, 55], [6, 79], [5, 80], [0, 80]];

difference() {
  rotate_extrude() polygon(profile);
}
