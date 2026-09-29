$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 25, 14, 10 mm, 110 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
total = 110;              // overall length
chamfer = 2;              // end chamfer
groove_r = 12.5;          // groove radius
groove_z = 42;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 2;             // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 40], [12.5, 40], [12.5, 65], [7, 65], [7, 95], [5, 95], [5, 108], [3, 110], [0, 110]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
