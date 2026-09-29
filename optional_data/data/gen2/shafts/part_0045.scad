$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 16, 10 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 30;                // step 3 length
total = 90;               // overall length
chamfer = 2.5;            // end chamfer
groove_r = 8;             // groove radius
groove_z = 32;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1.6;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 30], [8, 30], [8, 60], [5, 60], [5, 87.5], [2.5, 90], [0, 90]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
