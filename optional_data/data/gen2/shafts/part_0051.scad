$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 25, 16, 12 mm, 110 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 20;                // step 4 length
d5 = 12;                  // step 5 diameter
len5 = 40;                // step 5 length
total = 110;              // overall length
chamfer = 1;              // end chamfer
groove_r = 12.5;          // groove radius
groove_z = 22;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.6;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 10], [15, 10], [15, 20], [12.5, 20], [12.5, 50], [8, 50], [8, 70], [6, 70], [6, 109], [5, 110], [0, 110]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
