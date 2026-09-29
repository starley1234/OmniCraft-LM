$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 20, 16 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 40;                // step 3 length
total = 105;              // overall length
chamfer = 1;              // end chamfer
groove_r = 8;             // groove radius
groove_z = 67;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 2;             // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 40], [10, 40], [10, 65], [8, 65], [8, 104], [7, 105], [0, 105]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
