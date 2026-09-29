$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 20, 16 mm, 65 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 25;                // step 3 length
total = 65;               // overall length
chamfer = 2.5;            // end chamfer
groove_r = 10;            // groove radius
groove_z = 27;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1;             // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 25], [10, 25], [10, 40], [8, 40], [8, 62.5], [5.5, 65], [0, 65]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
