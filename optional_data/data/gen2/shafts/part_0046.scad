$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 12, 8 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 12;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 30;                // step 3 length
total = 90;               // overall length
chamfer = 2;              // end chamfer
groove_r = 4;             // groove radius
groove_z = 62;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1.3;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [15 - chamfer, 0], [15, chamfer], [15, 30], [6, 30], [6, 60], [4, 60], [4, 88], [2, 90], [0, 90]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
