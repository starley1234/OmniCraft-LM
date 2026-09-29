$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 20, 14, 8 mm, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 30;                // step 4 length
total = 120;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 7;             // groove radius
groove_z = 82;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1.3;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 40], [10, 40], [10, 80], [7, 80], [7, 90], [4, 90], [4, 118.5], [2.5, 120], [0, 120]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
