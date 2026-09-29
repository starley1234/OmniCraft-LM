$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 25, 20, 8 mm, 75 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 30;                // step 4 length
total = 75;               // overall length
chamfer = 2.4;            // end chamfer
groove_r = 12.5;          // groove radius
groove_z = 17;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1.3;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [15 - chamfer, 0], [15, chamfer], [15, 15], [12.5, 15], [12.5, 35], [10, 35], [10, 45], [4, 45], [4, 72.6], [1.6, 75], [0, 75]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
