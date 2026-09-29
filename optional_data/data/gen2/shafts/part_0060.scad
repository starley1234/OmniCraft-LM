$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 16, 14 mm, 65 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 40;                // step 3 length
total = 65;               // overall length
chamfer = 2;              // end chamfer
groove_r = 8;             // groove radius
groove_z = 12;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 2;             // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 10], [8, 10], [8, 25], [7, 25], [7, 63], [5, 65], [0, 65]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
